*** Settings ***
Library           SSHLibrary

*** Keywords ***
SSH_to_target_client
    [Arguments]    ${client_ip}    ${cli_username}    ${cli_password}
    [Documentation]    SSH to target client.
    ...    ${val} describe:
    ...    ${client_ip} : target ip
    ...    ${cli_username} : your log in username
    ...    ${cli_password} : your log in password
    Open Connection    ${client_ip}    22
    Login    ${cli_username}    ${cli_password}

mount_and_check_list
    [Arguments]    ${server_ip}    ${server_hostname}
    [Documentation]    Mount the nfs_share.
    ...    ${server_ip} : the nfs_share server's ip
    ...    ${server_hostname} : because of filesystem==hostname
    write    mkdir /mnt/nfs
    write    mount -t nfs -o vers=4 ${server_ip}:/cloudfs/${server_hostname} /mnt/nfs
    sleep    2
    ${output}    Execute Command    mount
    Should Contain    ${output}    ${server_ip}

check_the_files_create
    [Documentation]    After mount successfully,create some files/folders under the share folder.
    write    touch /mnt/nfs/111111
    ${t3}    Execute Command    ls /mnt/nfs
    Run Keyword And Continue On Failure    Should Contain    ${t3}    111111

cleanup_mount
    [Documentation]    Clean up the mount env.
    write    rm /mnt/nfs/111111
    write    umount /mnt/nfs
    write    rm -rf /mnt/nfs
    Close Connection

Mount_Create_check
    [Arguments]    ${cli_info}
    [Documentation]    From log in to clean up. include <create> <check files>
    ...    ${cli_info} : is a dict,need 5 infos. <server ip> <server: username> <server: password> <server host name> <client ip>.
    SSH_to_target_client    ${cli_info.s1}    ${cli_info.scu}    ${cli_info.scp}
    ${t1}    Execute Command    ls /cloudfs/${cli_info.s4} |wc -l
    Close Connection
    SSH_to_target_client    ${cli_info.c1}    ${cli_info.scu}    ${cli_info.scp}
    mount_and_check_list    ${cli_info.s1}    ${cli_info.s4}
    ${t2}    Execute Command    ls /mnt/nfs |wc -l
    Should Contain    ${t1}    ${t2}
    check_the_files_create
    cleanup_mount
