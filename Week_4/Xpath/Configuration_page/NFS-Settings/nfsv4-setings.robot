*** Variables ***
${nfsv4settingsLbl}    //div[contains(text(),'NFSv4 Settings') and @class='title']
${nfsv4SettingsEnableV4ModeChk}    id=nfsv4Mode
${kerveros}       //div[@id='nfsv4Kerberos']
${kerveros_ad}    //div[text()='ad']
${kerveros_none}    //div[contains(@style,'margin-left: 0px;')]/div[text()='none']
${Security}       //div[@id='nfsv4Security']
${sec}            //div[text()='sys']
${nfsv4SettingsRootAccessTxt}    id=nfsv4RootAccess
${delagation}     //input[@name='nfsv4Delegation']
