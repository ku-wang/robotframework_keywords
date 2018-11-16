*** Settings ***
Library           Selenium2Library

*** Keywords ***
Navigate to page
    [Arguments]    ${username}    ${password}    ${page}
    [Documentation]    Open navigate page.
    ...    About ${var} describe:
    ...    ${page}: like 'Cloudfs'
    ...    @{userinfo}: <username>/<password>
    Maximize Browser Window
    Input Text    //input[contains(@id,'undefined-undefined-Username-')]    ${username}
    Input Text    //input[contains(@id,'undefined-undefined-Password-')]    ${password}
    Click Element    //*[@id="content"]/div/div/div/div[2]/button/div/span
    Wait Until Element Contains    //div[@class='header-tab-button home']    HOME
    Wait Until Element Contains    //div[@class='home-menu-buttons']    ${page}
    Click Element    //span[text()='${page}']

Add simple nfs-export
    [Arguments]    ${ip}    ${pending}
    [Documentation]    Add a simple nfs-export.
    ...    Only need a ip.
    Input Text    //input[@label='Host/Network']    ${ip}
    ${text}    Get Element Attribute    //input[@label='Host/Network']    value
    Should Be Equal    ${ip}    ${text}
    Click Button    //span[text()='Add']/../..
    Wait Until Element Is Enabled    //span[text()='save']/../..
    sleep    1
    Click Button    //span[text()='save']/../..
    Wait Until Element Is Not Visible    ${pending}    10

Text exist handle
    [Arguments]    ${path}    ${expect_text}
    [Documentation]    Input a locator and expect text.
    ...    The actual results and expect results should be equal.
    ${exports}=    Get Text    ${path}
    Run Keyword And Continue On Failure    Should Contain    ${exports}    ${expect_text}

add plex nfs
    [Arguments]    ${test_info}
    [Documentation]    Add a complex nfs-export.
    ...    ${var} describe:
    ...    ${test_info} : should be a dict,include 8 infos.<usenetwork: 0/1> <Fillesystem> <Exports> <Host/Networks : ip> <permission: No/Yes> <Alldirs: No/Yes> <root_access: No/Yes> <Description>
    ...    ${pending} : is a <xpath> for penging changes.
    Run Keyword If    '${test_info.n1}'=='0'    Click Element    ${Add_export_use_networks}
    # select filesysy
    Click Element    ${Add_export_filesystem}
    sleep    3
    Click Button    ${Add_export_add}
    Click Element    ${Add_export_filesystem}
    # importance
    Wait Until Element Is Visible    //div[text()='${test_info.n2}' and not(@style)]    10
    Click Element    //div[text()='${test_info.n2}' and not(@style)]
    # add export
    Run Keyword If    '${test_info.n6}'=='empty'    log    pass
    ...    ELSE    Input Text    ${Add_export_exports}    ${test_info.n6}
    # add hosts
    Input Text    ${Add_export_host/network}    ${test_info.n7}
    # select permission
    Click Element    ${Add_export_permission}
    sleep    1
    Click Element    //div[text()='${test_info.n3}' and not(@style)]
    # select dirs
    sleep    1
    Click Element    ${Add_export_dirs}
    sleep    1
    ${test_info.n4}    Set Variable    ${test_info.n4[1:]}
    Click Element    //div[text()='${test_info.n4}' and not(@style)]
    # select access
    sleep    1
    Click Element    ${Add_export_root_access}
    Sleep    1
    ${test_info.n5}    Set Variable    ${test_info.n5[1:]}
    Click Element    //div[text()='${test_info.n5}' and not(@style)]
    # input des
    Input Text    ${Add_export_description}    ${test_info.n8}
    # add and save
    sleep    1
    Click Button    ${Add_export_add}
    Wait Until Element Is Enabled    //span[text()='save']/../..    10
    sleep    1
    Click Button    //span[text()='save']/../..
    Wait Until Element Is Not Visible    ${pending_all}    30

same_nfs_export_no_pending
    [Arguments]    ${ip}
    [Documentation]    same with simple nfs-export but no pending changes save.
    Input Text    //input[@label='Host/Network']    ${ip}
    ${text}    Get Element Attribute    //input[@label='Host/Network']    value
    Should Be Equal    ${ip}    ${text}
    Click Button    //span[text()='Add']/../..
    Wait Until Element Is Enabled    //span[text()='save']/../..
    sleep    1
    Click Button    //span[text()='save']/../..
    Wait Until Element Is Visible    //h3    10

after_click_then_check_exist
    [Arguments]    ${click_obt}    ${check_target_xpath}    ${check_value}
    [Documentation]    Click a element,then check the info under the pop pages.
    Click Element    ${click_obt}
    Text exist handle    ${check_target_xpath}    ${check_value}

Force clear value
    [Arguments]    ${lactor}    ${value_}
    [Documentation]    Force delete the value on the input fields.
    ...    <Lactor> and <attribute> (like 'id' 'name') is necessary.
    ${value_exports}    Get Element Attribute    ${lactor}    ${value_}
    ${length_exports}    Get Length    ${value_exports}
    : FOR    ${i}    IN RANGE    ${length_exports}
    \    Press Key    ${lactor}    \ue003\ue017
