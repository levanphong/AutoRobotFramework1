*** Settings ***
Variables       ../../locators/client_setup_locators.py
Resource        ../../pages/location_management_page.robot
Resource        ../../pages/base_page.robot
Resource        ../../drivers/driver_chrome.robot

*** Variables ***
${test_location}    auto_test_location
${test_user}        Recruiter Team

*** Test Cases ***
Run script
    Prepare data test

*** Keywords ***
Prepare data test
    Open Chrome
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_OFF}
    Add a Location    ${COMPANY_FRANCHISE_OFF}    ${test_location}
    Go to CEM page
    Switch to Company v1  ${COMPANY_HIRE_OFF}
    Add a Location    ${COMPANY_HIRE_OFF}    ${test_location}
    # Assign user to location  ${test_location}

# Create company                    Test Automation New Role
#                                   Test Automation Franchise Off Job On
#                                   Client Setup > Compliance and Security > Change `Will your users log in with a phone number or email address?` to `Email`

# COMPANY_FRANCHISE_ON              Campus page: Client Setup > Campus > Turn ON `Campus` toggle
#                                   Integration Center: Client Setup > Integrations > Turn ON `Integration Center` toggle
#                                   Job Data Packages: Client Setup > Hire > Turn on Job toggle > Turn on `Job Data Packages` toggle
#                                   Campaigns: Client Setup > Campaigns > Turn ON `Campaigns` toggle
#                                   Create olivia.automation+rp@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`) user -> Set pass to 1345
#                                   Talent Community: Client Setup > Talent Community > Turn ON `Talent Community` toggle
#                                   Create a Custom Conversation for Talent Community and Publish
#                                   Talent Community: Client Setup > Talent Community > Select a Conversation for Talent
#                                   Login with viewonly.prod@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`) Talent Community: Client Setup > More > Turn ON `Microlearning` toggle

# COMPANY_FRANCHISE_OFF_JOB_ON      Job Data Packages: Client Setup > Hire > Turn on Job toggle > Turn on Job Data Packages toggle
#                                   Candidate Journeys: Client Setup > Hire > Turn on `Candidate Journey` toggle
#                                   Create User and User roles: Company Admin, Supervisor, Full User - Edit Nothing, Full User - Edit Everything, Hiring Manager, Recruiter, Reporting User
#                                   Create Job family   Coffee family job
#                                   Create location     Vintners Place
#                                   Add all users to `Vintners Place` location

# COMPANY_FRANCHISE_OFF             Create olivia.automation+rp@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`) user     Reporting Team
#                                   Talent Community: Client Setup > Talent Community > Turn ON `Talent Community` toggle
#                                   Create a Custom Conversation for Talent Community and Publish
#                                   Talent Community: Client Setup > Talent Community > Select a Conversation for Talent
#                                   Campus page: Client Setup > Campus > Turn ON `Campus` toggle
#                                   Add all users to `auto_test_location` location

# COMPANY_NEW_ROLE                  Create olivia.automation+rp@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`) user     Reporting Team
# COMPANY_NEW_ROLE                  Create olivia.automation+pu@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`) user     Power Team
#                                   Talent Community: Client Setup > Talent Community > Turn ON `Talent Community` toggle
#                                   Create a Custom Conversation for Talent Community and Publish
#                                   Talent Community: Client Setup > Talent Community > Select a Conversation for Talent

# COMPANY_HIRE_ON                   Create olivia.automation+ca@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`)      CA Team
#                                   Job Boards: Client Setup > Hire > Turn on `Olivia Hire` toggle > Turn on `Jobs` toggle > Select all Job types
#                                   Talent Community: Client Setup > Talent Community > Turn ON `Talent Community` toggle
#                                   Create a Custom Conversation for Talent Community and Publish
#                                   Talent Community: Client Setup > Talent Community > Select a Conversation for Talent

# COMPANY_HIRE_OFF                  Talent Community: Client Setup > Talent Community > Turn ON `Talent Community` toggle
#                                   Create a Custom Conversation for Talent Community and Publish
#                                   Talent Community: Client Setup > Talent Community > Select a Conversation for Talent
#                                   Add Recruiter role
#                                   Add all users to `auto_test_location` location

# COMPANY_EVENT                     Interview Prep: Client Setup > Scheduling > Turn ON `Interview Prep` toggle
#                                   Recorded Interview Builder: Client Setup > Scheduling > Turn ON `Olivia Recorded Interviews` toggle
#                                   Create olivia.automation+ca@paradox.ai (Depend on ENV, change `olivia.automation` or `olivia.automation1` or `olivia.automation2`)      CA Team
#                                   Create an Event conversation and Publish

