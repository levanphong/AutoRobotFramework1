*** Settings ***
Library     ../utils/NameUtils.py
Library     ../utils/IOAction.py
Library     SeleniumLibrary
Library     String
Resource    ../constants/variables_resource.robot

*** Keywords ***
Open Chrome
    [Arguments]    ${window_w}=1920    ${window_h}=1080
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${dir_download} =   get_download_path
    &{prefs} =  Create Dictionary    profile.default_content_settings.popups=0  download.default_directory=${dir_download}
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    incognito
    Call Method    ${chrome_options}    add_experimental_option     prefs   ${prefs}
    ${VERSION_CHROME_DRIVER} =  get_chrome_version
    ${chrome_driver} =    get_path_driver  ${VERSION_CHROME_DRIVER}
    Create Webdriver    Chrome    chrome_options=${chrome_options}    executable_path=${chrome_driver}
    Set Window Size    ${window_w}    ${window_h}
    Set Selenium Implicit Wait      5s
    Set Selenium Timeout        30s
    ${path_screenshot} =    get path screenshot
    Set Global Variable    ${Path}    ${path_screenshot}
    Set Screenshot Directory    ${Path}
    Set Company Name to Global
