*** Settings ***
Resource    ../../pages/sample_page.robot
Resource    ../../drivers/driver_chrome.robot

Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome



