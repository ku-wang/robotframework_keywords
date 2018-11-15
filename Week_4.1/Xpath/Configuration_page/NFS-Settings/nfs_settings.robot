*** Variables ***
${NFS_Exports_link}    //div[@class='title' and text()='NFS Exports']    # NFS Settings-NFS Export
${Add_export_add_button}    //div[@class='config-button-group']/button[1]
${Add_export_use_networks}    //input[@name='networkMode']
${Add_export_filesystem}    //div[contains(@id,'Filesystem-undefined-Filesystem')]
${Add_export_filesystem_pop}    //div[contains(@style,'z-index: 1000; top: 0px;')]
${Add_export_exports}    //input[@name='path']
${Add_export_host/network}    //input[@name='hosts']
${Add_export_permission}    //div[@id='permission']
${Add_export_dirs}    //div[@id='alldirs']
${Add_export_root_access}    //div[@id='noRootSquash']
${Add_export_description}    //input[@name='description']
${Add_export_cancel}    //div[./h3[contains(text(),'Add Export')]]//button[.//span[text()='Cancel']]
${Add_export_add}    //div[./h3[contains(text(),'Add Export')]]//button[.//span[text()='Add']]
&{permison_son}    Add_export_RW=//div[@style='opacity: 1;'][1]    Add_export_RO=//div[@style='opacity: 1;'][2]
&{alldirs_son}    Add_export_no=//div[@style='opacity: 1;'][1]    Add_export_yes=//div[@style='opacity: 1;'][2]
&{Root_access_son}    Add_export_no=//div[@style='opacity: 1;'][1]    Add_export_yes=//div[@style='opacity: 1;'][2]
${same_export_pop}    //div[@style='margin-top: 5px;']
${Add_export_text}    //h3
