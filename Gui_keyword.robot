*** Settings ***
Library           Selenium2Library

*** Keywords ***
Navigate page
    [Arguments]    ${ip}    ${page}    @{user_info}
    Open Browser    ${ip}    chrome
    Maximize Browser Window
    Input Text    //input[contains(@id,'undefined-undefined-Username-')]    @{user_info}[0]
    Input Text    //input[contains(@id,'undefined-undefined-Password-')]    @{user_info}[1]
    Click Element    //*[@id="content"]/div/div/div/div[2]/button/div/span
    Wait Until Element Contains    //*[@id="content"]/div/div[1]/header/div[2]/div/div    HOME
    Wait Until Element Contains    //div[@class='home-menu-buttons']    ${page}
    Click Element    //span[text()='${page}']

Text exist handle
    [Arguments]    ${path}    ${expect_text}
    ${exports}    Get Text    ${path}
    Run Keyword And Continue On Failure    Should Be Equal    ${exports}    ${expect_text}

Add a nfs-export
    [Arguments]    ${ip}
    Input Text    //input[@label='Host/Network']    ${ip}
    ${text}    Get Element Attribute    //input[@label='Host/Network']    value
    Run Keyword And Continue On Failure    Should Be Equal    ${ip}    ${text}
    Click Button    //span[text()='Add']/../..
    Wait Until Element Is Enabled    //span[text()='save']/../..
    sleep    1
    Run Keyword And Continue On Failure    Click Button    //span[text()='save']/../..
