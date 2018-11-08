*** Settings ***
Library           Selenium2Library
Resource          ../Keywords/Configuration_keywords.robot
Variables         ../testinfo/test.yaml
Resource          ../xpath/Configuration_page/NFS-Settings/nfs_settings.txt
Resource          ../xpath/Configuration_page/Main_page_link/Navigate_menu.txt
Resource          ../xpath/Configuration_page/NFS-Settings/NFSv4_settings.txt
Library           SSHLibrary
Resource          ../Keywords/SSH_Test.robot
Resource          ../Keywords/NFS_keywords_long_step.robot

*** Variables ***
${pending}        //div[@class='title' and text()='Pending Changes']
${add_export_window_text}    Add Export

*** Test Cases ***
QT-45241 GUI-Configuration-NFS Settings-NFS Exports-add a nfs export with duplicate ip
    [Documentation]    With two nfs-export, filesystem In the same case, the host is not allowed to be the same or has the inclusion
    [Tags]    Plan A    Plan B
    [Setup]    Open Browser    ${ip_address}    chrome
    [Timeout]    3 minutes
    # go to nfs-export
    Navigate to page    ${username}    ${password}    ${page.p3}
    Check_nfs_exports_page    ${nfsSettingsOpt}    ${NFS_Exports_link}    ${Add_export_add_button}
    # click 'add',check the window
    after_click_then_check_exist    ${Add_export_add_button}    ${Add_export_text}    ${add_export_window_text}
    # add a nfs-export
    Add simple nfs-export    ${host_networks}    ${pending}
    #add same host and check the prompt
    after_click_then_check_exist    ${Add_export_add_button}    ${Add_export_text}    ${add_export_window_text}
    same_nfs_export_no_pending    ${host_networks}
    Text exist handle    ${same_export_pop}    The current /cloudfs rule is already defined for hosts ${host_networks}.
    [Teardown]    close browser

QT-45218 GUI-Configuration-NFS Settings-NFS v4 settings-Can mount after enable NFS V4 settings
    [Documentation]    After nfsv4 enable, it should be successful with v4 mount
    [Tags]    Plan A    Plan B
    [Setup]    open browser    ${ip_address}    chrome
    [Timeout]    3 minutes
    # Add nfs-export
    Navigate to page    ${username}    ${password}    ${page.p3}
    Check_nfs_exports_page    ${nfsSettingsOpt}    ${NFS_Exports_link}    ${Add_export_add_button}
    after_click_then_check_exist    ${Add_export_add_button}    ${Add_export_text}    ${add_export_window_text}
    # add nfs-export
    add plex nfs    ${nfs1}    ${pending}
    # enable v4
    Enable_V4_Mode    ${nfsv4settingsLbl}    ${nfsv4SettingsEnableV4ModeChk}    ${pending_save}    ${pending}
    # ssh to client and mount test
    Mount_Create_check    ${nfs_cli_1}
    [Teardown]    close browser
