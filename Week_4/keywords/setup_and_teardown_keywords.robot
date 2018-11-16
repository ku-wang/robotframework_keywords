*** Settings ***
Library           SSHLibrary
Library           Selenium2Library

*** Keywords ***
close_con_and_browser
    Close All Connections
    Close All Browsers
