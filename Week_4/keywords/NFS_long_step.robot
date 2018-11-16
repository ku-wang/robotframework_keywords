*** Settings ***
Library           Selenium2Library

*** Keywords ***
plex_V4_Mode
    [Arguments]    ${test_v4_info}
    [Documentation]    Enable the NFSv4 settings.
    Click Element    ${nfsv4settingsLbl}
    sleep    1
    Run Keyword If    '${test_v4_info.v1}'=='0'    Click Element    ${nfsv4SettingsEnableV4ModeChk}
    Run Keyword If    '${test_v4_info.v2}'=='ad'    Run Keyword    select_kerver    ${test_v4_info.v2}
    ...    ELSE IF    '${test_v4_info.v2}'=='none'    Run Keyword    select_kerver    ${test_v4_info.v2}
    Run Keyword If    '${test_v4_info.v3}'=='empty'    log    pass
    ...    ELSE    Run Keyword    select_secur    ${test_v4_info.v3}
    Run Keyword If    '${test_v4_info.v4}'=='empty'    log    pass
    ...    ELSE    Run Keyword    Input Text    ${nfsv4SettingsRootAccessTxt}    ${test_v4_info.v4}
    Run Keyword If    '${test_v4_info.v5}'=='0'    Click Element    ${delagation}
    Wait Until Element Is Enabled    ${pending_save}
    sleep    1
    Click Button    ${pending_save}
    Wait Until Element Is Not Visible    ${pending_all}    10
    Click Element    ${nfsv4settingsLbl}
    sleep    1

add_exports_window
    [Documentation]    Check the nfs_export page.
    sleep    1
    Click Element    ${nfsSettingsOpt}
    sleep    1
    Click Element    ${NFS_Exports_link}
    Wait Until Element Is Enabled    ${Add_export_add_button}
    sleep    1
    Click Button    ${Add_export_add_button}

select_kerver
    [Arguments]    ${select}
    Click Element    ${kerveros}
    sleep    1
    Run Keyword If    '${select}'=='ad'    Click Element    ${kerveros_ad}
    ...    ELSE    Click Element    ${kerveros_none}
    sleep    1

select_secur
    [Arguments]    ${sec_sel}
    Click Element    ${Security}
    sleep    1
    Click Element    //div[text()='${sec_sel}']

make_sure_v4_disable
    Click Element    ${nfsv4settingsLbl}
    Click Element    ${nfsv4settingsLbl}
