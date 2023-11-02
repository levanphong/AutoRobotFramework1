*** Settings ***
Variables       ../../../locators/candidate_journeys_locators.py

*** Keywords ***
Prepare candidate journey Data test for Suite
    Run Setup Only Once    Prepare candidate journey Data test

Prepare candidate journey Data test
    Open Chrome
    Given Setup test
    when Login into system with company    Paradox admin role    ${COMPANY_FRANCHISE_ON}
    Check and create a new offer     ${offer_for_job}
    check and create landing site/widget site       Landing Site    ${landing_site_job_internal}
