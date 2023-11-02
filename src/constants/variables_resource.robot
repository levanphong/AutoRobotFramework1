*** Variables ***
#DEFAULT CONFIG HERE //
${env}                                              STG
${BASE_URL}                                         https://stg.paradox.ai
${PASSWORD}                                         1345
${TEMPLATE_EVENT_AUTO}                              TEMPLATE_EVENT_AUTO
${chromedriver}                                     /usr/local/bin/chromedriver
${sys_attribute}                                    auto_custom_candidate_attr


*** Keywords ***
Set Company Name to Global
    # Read company name from json
    ${json}=  Get file  resources/company_name.json
    # Convert json data from Robot type to Python object
    ${object}=  Evaluate  json.loads('''${json}''')  json
    # Set company name to global
    Set Global Variable    ${COMPANY_FRANCHISE_ON}                          ${object["COMPANY_FRANCHISE_ON"]}
    Set Global Variable    ${COMPANY_FRANCHISE_OFF}                         ${object["COMPANY_FRANCHISE_OFF"]}
    Set Global Variable    ${COMPANY_FRANCHISE_OFF_JOB_ON}                  ${object["COMPANY_FRANCHISE_OFF_JOB_ON"]}
    Set Global Variable    ${COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE}     ${object["COMPANY_SCHEDULE_BASE_CANDIDATE_TIME_ZONE"]}
    Set Global Variable    ${COMPANY_COMMON}                                ${object["COMPANY_COMMON"]}
    Set Global Variable    ${COMPANY_NEXT_STEP}                             ${object["COMPANY_NEXT_STEP"]}
    Set Global Variable    ${COMPANY_DATA_PACKAGE_OFF}                      ${object["COMPANY_DATA_PACKAGE_OFF"]}
    Set Global Variable    ${COMPANY_HIRE_ON}                               ${object["COMPANY_HIRE_ON"]}
    Set Global Variable    ${COMPANY_HIRE_OFF}                              ${object["COMPANY_HIRE_OFF"]}
    Set Global Variable    ${COMPANY_FLEXIBLE_HIRE}                         ${object["COMPANY_FLEXIBLE_HIRE"]}
    Set Global Variable    ${COMPANY_APPLICANT_FLOW}                        ${object["COMPANY_APPLICANT_FLOW"]}
    Set Global Variable    ${COMPANY_EVENT}                                 ${object["COMPANY_EVENT"]}
    Set Global Variable    ${COMPANY_NEW_ROLE}                              ${object["COMPANY_NEW_ROLE"]}
    Set Global Variable    ${COMPANY_LOCATION_MAPPING_OFF}                  ${object["COMPANY_LOCATION_MAPPING_OFF"]}
    Set Global Variable    ${COMPANY_EXTERNAL_JOB}                          ${object["COMPANY_EXTERNAL_JOB"]}
    Set Global Variable    ${COMPANY_CVS_EVENT}                             ${object["COMPANY_CVS_EVENT"]}
    Set Global Variable    ${COMPANY_JOB_SEARCH_PARAMETER_OFF}              ${object["COMPANY_JOB_SEARCH_PARAMETER_OFF"]}
    Set Global Variable    ${COMPANY_JOB_SEARCH_PARAMETER_ON}               ${object["COMPANY_JOB_SEARCH_PARAMETER_ON"]}
    Set Global Variable    ${COMPANY_GEOGRAPHIC_TARGETING}                  ${object["COMPANY_GEOGRAPHIC_TARGETING"]}
    Set Global Variable    ${COMPANY_PARADOX_I9}                            ${object["COMPANY_PARADOX_I9"]} ${env}
    Set Global Variable    ${COMPANY_TEST_ASSESSMENT}                       ${object["COMPANY_TEST_ASSESSMENT"]}
    Set Global Variable    ${COMPANY_DYNAMIC_CONVERSATION}                  ${object["COMPANY_DYNAMIC_CONVERSATION"]}
