*** Settings ***
Library           Selenium2Library
Resource          GUI-configuration.txt
Variables         var.py

*** Variables ***
${color_blue}     rgb(68, 98, 197)
@{userinfo}       admin    P@ssw0rd

*** Test Cases ***
QT-45189 GUI-Configuration-Pending Changes-NFS Settings-NFS v4 Settings-Negative Testing
    [Documentation]    (1)Test the pending changes display. \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ (2)The check point->Check the <pending changes> background color.
    ...    (3)This case timeout is 3minutes.
    [Timeout]    3 minutes
    Open NFSv4-Settings    https://10.180.207.192
    Input invalid text    ${special_text }    ${color_blue}
    Empty v4 input    ${color_blue}
    Click Cancle button
    Close Browser

QT-45307 GUI-Configuration-Network Settings-Cloud Bandwidth Limits-Expected Cloud Bandwidth Limit-input some special characters
    [Documentation]    Check the prompt when input some special text.
    [Timeout]    3 minutes
    # Navigate to configuration page
    Open Home    https://10.180.207.192
    Open configuration page
    # Navigate to <Expected Cloud Bandwidth Limit>
    sleep    2
    Click Element    //div[@class='title' and text()='Network Settings']
    sleep    2
    Wait Until Element Is Visible    //div[text()='Cloud Bandwidth Limits']
    Click Element    //div[text()='Cloud Bandwidth Limits']/..
    Wait Until Element Contains    //h4[1]    Expected Cloud Bandwidth Limit
    # Input alphabet/Chinese
    Force clear value    //input[@id='defaultBandwidth.upload']    value
    Input Text    //input[@id='defaultBandwidth.upload']    ${alphabet}
    Force clear value    //input[@id='defaultBandwidth.download']    value
    Input Text    //input[@id='defaultBandwidth.download']    ${alphabet}
    ${count_1}    Get Element Count    //div[text()='Must be a number']
    Run Keyword And Continue On Failure    Run Keyword If    '${count_1}'=='2'    log    pass
    # Input negative number
    Force clear value    //input[@id='defaultBandwidth.upload']    value
    Input Text    //input[@id='defaultBandwidth.upload']    ${nagetive_number}
    Force clear value    //input[@id='defaultBandwidth.download']    value
    Input Text    //input[@id='defaultBandwidth.download']    ${nagetive_number}
    ${count_2}    Get Element Count    //div[text()='Must be greater than 0']
    Run Keyword And Continue On Failure    Run Keyword If    '${count_2}'=='2'    log    pass
    # Input the special characters
    Force clear value    //input[@id='defaultBandwidth.upload']    value
    Input Text    //input[@id='defaultBandwidth.upload']    ${special_text}
    Force clear value    //input[@id='defaultBandwidth.download']    value
    Input Text    //input[@id='defaultBandwidth.download']    ${special_text}
    ${count_3}    Get Element Count    //div[text()='Must be a number']
    Run Keyword And Continue On Failure    Run Keyword If    '${count_3}'=='2'    log    pass
    # Input a decimal
    Force clear value    //input[@id='defaultBandwidth.upload']    value
    Input Text    //input[@id='defaultBandwidth.upload']    ${decimal}
    Force clear value    //input[@id='defaultBandwidth.download']    value
    Input Text    //input[@id='defaultBandwidth.download']    ${decimal}
    Wait Until Element Contains    //*[@id="content"]/div/div[3]/div/div[2]/div[4]/div/div[1]/div[1]    Pending Changes
    ${color_1}    Get Element Attribute    //div[@class='confirm']/div/button[1]    style
    Run Keyword And Continue On Failure    Should Contain    ${color_1}    ${color_blue}
    # Close
    Close Browser

*** Keywords ***
