*** Settings ***
Library           SSHLibrary

*** Keywords ***
SSH_to_target_client
    [Arguments]    ${cli_info}
    [Documentation]    SSH to target client.
    ...    ${val} describe:
    ...    ${client_ip} : target ip
    ...    ${cli_username} : your log in username
    ...    ${cli_password} : your log in password
    Open Connection    ${cli_info.c1}    22    timeout=20
    Login    ${cli_info.scu}    ${cli_info.scp}
    sleep    1

mount_and_check_list
    [Arguments]    ${server_ip}    ${server_hostname}
    [Documentation]    Mount the nfs_share.
    ...    ${server_ip} : the nfs_share server's ip
    ...    ${server_hostname} : because of filesystem==hostname
    write    mkdir /mnt/nfs
    write    mount -t nfs -o vers=4 ${server_ip}:/cloudfs/${server_hostname} /mnt/nfs
    sleep    2
    ${output_2}    Execute Command    mount
    Should Contain    ${output_2}    ${server_ip}

check_the_files_create
    [Documentation]    After mount successfully,create some files/folders under the share folder.
    write    touch /mnt/nfs/111111
    ${t3}    Execute Command    ls /mnt/nfs
    Run Keyword And Continue On Failure    Should Contain    ${t3}    111111

cleanup_mount
    [Documentation]    Clean up the mount env.
    write    umount /mnt/nfs
    write    rm -rf /mnt/nfs

Mount_Create_check
    [Arguments]    ${cli_info}
    [Documentation]    From log in to clean up. include <create> <check files>
    ...    ${cli_info} : is a dict,need 5 infos. <server ip> <server: username> <server: password> <server host name> <client ip>.
    SSH_to_target_client    ${cli_info.s1}
    ${t1}    Execute Command    ls /cloudfs/${cli_info.s4} |wc -l
    Close Connection
    SSH_to_target_client    ${cli_info.c1}
    mount_and_check_list    ${cli_info.s1}    ${cli_info.s4}
    ${t2}    Execute Command    ls /mnt/nfs |wc -l
    Should Contain    ${t1}    ${t2}
    check_the_files_create
    cleanup_mount

check_etc_exports
    [Arguments]    ${sec_select}    ${export_ip}
    ${t1}    Execute Command    cat /etc/exports
    Run Keyword And Continue On Failure    Should Contain    ${t1}    V4:/ -sec=${sec_select} ${export_ip}

mount_fail_and_cleanup
    [Arguments]    ${cli_info}
    write    mkdir /mnt/nfs
    write    mount -t nfs -o vers=4 ${cli_info.s1}:/cloudfs/${cli_info.s4} /mnt/nfs
    ${ou1}    Read    delay=0.8s
    Should Contain    ${ou1}    version mismatch; low version = 2, high version = 3
    Execute Command    rm -rf /mnt/nfs
    Close Connection

SSH_to_target_server
    [Arguments]    ${cli_info}
    Open Connection    ${cli_info.s1}    22    timeout=20
    Login    ${cli_info.scu}    ${cli_info.scp}
    sleep    1
