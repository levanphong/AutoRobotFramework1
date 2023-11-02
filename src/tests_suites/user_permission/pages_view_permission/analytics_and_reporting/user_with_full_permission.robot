*** Settings ***
Resource            ./analytics_and_reporting.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check user has perm full access to Admin Reports on the Analytics and Reporting page (OL-16963)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_HIRE_OFF}
    Send a Report   Admin


Check user has perm full access to Campaign Reports on the Analytics and Reporting page (OL-16966)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Send a Report    Campaigns


Check user has perm full access to Candidate Care Reports on the Analytics and Reporting page (OL-16964)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Send a Report    Candidate Care


Check user has perm full access to Hire report on the Analytics and Reporting page (OL-16961)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Send a Report    Hire


Check user has perm full access to Dashboard - Scheduling on the Analytics and Reporting page (OL-T16958)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Scheduling


Check user has perm full access to Hire - Dashboard on the Analytics and Reporting page (OL-T16959)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Hire


Check user has perm full access to Rating - Dashboard on the Analytics and Reporting page (OL-T16960)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Ratings


Check user has perm full access to Dashboard - Dashboard on the Analytics and Reporting page (OL-16957)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_HIRE_OFF}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Dashboard

*** Keywords ***
