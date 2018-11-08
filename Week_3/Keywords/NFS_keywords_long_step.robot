*** Settings ***
Library           Selenium2Library

*** Keywords ***
Enable_V4_Mode
    [Arguments]    ${nfsv4settingsLbl}    ${nfsv4SettingsEnableV4ModeChk}    ${pending_save}    ${pending}
    [Documentation]    Enable the NFSv4 settings.
    Click Element    ${nfsv4settingsLbl}
    sleep    1
    Click Element    ${nfsv4SettingsEnableV4ModeChk}
    Wait Until Element Is Enabled    ${pending_save}
    sleep    1
    Click Button    ${pending_save}
    Wait Until Element Is Not Visible    ${pending}    10

Check_nfs_exports_page
    [Arguments]    ${nfsSettingsOpt}    ${NFS_Exports_link}    ${Add_export_add_button}
    [Documentation]    Check the nfs_export page.
    sleep    1
    Click Element    ${nfsSettingsOpt}
    sleep    1
    Click Element    ${NFS_Exports_link}
    Wait Until Element Is Enabled    ${Add_export_add_button}
