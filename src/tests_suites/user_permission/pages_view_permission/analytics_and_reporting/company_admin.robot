*** Settings ***
Resource            ./analytics_and_reporting.resource
Suite Teardown      Close All Browsers
Test Teardown       Close Browser
Test Setup          Open Chrome
Force Tags          lts_stg    olivia    regression    stg    test    pepsi    unilever    birddoghr    darden    aramark    fedex    fedexstg    mchire    stg_mchire    lowes    lowes_stg    lmco

*** Variables ***

*** Test Cases ***
Check User has Legacy role "Company Admin" has full access perm to Dashboard - Dashboard on the Analytics and Reporting page (OL-T19547)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Dashboard


Check User has Legacy role "Company Admin" has full access perm to Dashboard - Hire on the Analytics and Reporting page (OL-T19562)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Hire


Check User has Legacy role "Company Admin" has full access perm to Rating Dashboard on the Analytics and Reporting page (OL-T19557)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Ratings


Check User has Legacy role "Company Admin" has full access perm to Scheduling Dashboard on the Analytics and Reporting page (OL-T19552)
    Given Setup test
    when Login into system with company    Company Admin    ${COMPANY_FRANCHISE_ON}
    Go to Analytics and Reporting page
    Check user can update Dashboard / Scheduling

*** Keywords ***
