# BASE PAGE (ROLE ADMIN)
CANDIDATE_EXPERIENCE_BUTON = "//div[contains(@data-index, 'Candidate Experience')]"
ALERT_MANAGEMENT_USER_INPUT = "//input[contains(@id,'users-alerts')]"
# BASE PAGE / CANDIDATE EXPERIENCE (ROLE ADMIN)
CANDIDATE_EXPERIENCE_TITLE = "//div[contains(@class,'form-experience')]//div//div[contains(text(),'Manage who receives notifications when a candidate provides a low rating, reports a problem, or requests a person.')]"

CANDIDATE_EXPERIENCE_RATINGS_SECTION = "//*[contains(@data-sub-alert-type,'rating')]"
CANDIDATE_EXPERIENCE_RATINGS_TITLE = "//p[contains(@class,'title') and text()='Candidate Ratings']"
CANDIDATE_EXPERIENCE_RATINGS_DESCRIPTION = "//p[contains(@class,'title') and text()='Candidate Ratings']//following-sibling::label[contains(text(),'Manage if users receives notifications when a candidate provides a low rating.')]"
CANDIDATE_EXPERIENCE_RATINGS_INPUT = "//*[@id='users-ratings' and contains(@placeholder, 'Enter a name to add')]"

CANDIDATE_EXPERIENCE_REQUESTS_SECTION = "//*[contains(@data-sub-alert-type,'request')]"
CANDIDATE_EXPERIENCE_REQUESTS_TITLE = "//p[contains(@class,'title') and text()='Candidate Requests']"
CANDIDATE_EXPERIENCE_REQUESTS_DESCRIPTION = "//p[contains(@class,'title') and text()='Candidate Requests']//following-sibling::label[contains(text(),'Manage if users receives notifications when a candidate reports a problem or a request.')]"
CANDIDATE_EXPERIENCE_REQUESTS_INPUT = "//*[@id='users-requests' and contains(@placeholder, 'Enter a name to add')]"

CANDIDATE_EXPERIENCE_TOPIC_SELECTION_SECTION = "//*[contains(@class, 'topic-container')]"
CANDIDATE_EXPERIENCE_TOPIC_SELECTION_TITLE = "//p[contains(@class,'title') and text()='Topic Selection']"
CANDIDATE_EXPERIENCE_TOPIC_SELECTION_DESCRIPTION = "//p[contains(@class,'title') and text()='Topic Selection']//following-sibling::label[contains(text(),'Customize candidate conversations that can trigger notifications to enolled users.')]"
CANDIDATE_EXPERIENCE_TOPIC_SELECTION_INPUT = "//*[@id='dropdown-topics']"

# BASE PAGE / WORKFLOWS (ROLE ADMIN)
WORKFLOWS_USERS_ALERTS_FIRST_USER = "//div[contains(@class,'OlivAC-item') and contains(@data-index,'0')]"
WORKFLOWS_PATTERN_SUGGESTION_USER = "//div[contains(@class,'OlivAC-suggestions')]//div[contains(@class,'OlivAC-item') and not(contains(@class,'added'))]//div[contains(@class,'title') and contains(text(),'{}')]"
WORKFLOWS_PATTERN_SELECT_USER = "//div[contains(@class,'title') and contains(text(),'{}')]"
WORKFLOWS_PATTERN_RESULT_USER = "//div[contains(@class,'OlivAC-results')]//descendant::div[contains(@class,'title') and contains(text(),'{}')]"
WORKFLOWS_PATTERN_RESULT_USER_LOCATION_ICON = "//div[contains(@class,'OlivAC-results')]//descendant::div[contains(@class,'title') and contains(text(),'{}')]//parent::div[contains(@class,'info')]//following-sibling::div[contains(@class,'alert-options')]//i[contains(@class,'icon-location')]"
WORKFLOWS_PATTERN_RESULT_USER_NOTIFICATION_ICON = "//div[contains(@class,'OlivAC-results')]//descendant::div[contains(@class,'title') and contains(text(),'{}')]//parent::div[contains(@class,'info')]//following-sibling::div[contains(@class,'alert-options')]//i[contains(@class,'icon-notifications')]"
WORKFLOWS_PATTERN_RESULT_USER_DELETE_ICON = "//div[contains(@class,'OlivAC-results')]//descendant::div[contains(@class,'title') and contains(text(),'{}')]//parent::div[contains(@class,'info')]//following-sibling::div[contains(@class,'menu')]//span[contains(@class,'icon-remove')]"
WORKFLOWS_PATTERN_RESULT_USER_REMOVE_ICON = "//div[contains(@class,'OlivAC-results')]//descendant::div[contains(@class,'title') and contains(text(),'{}')]//parent::div[contains(@class,'info')]//following-sibling::div[contains(@class,'menu')]//child::span[contains(@class,'icon-remove')]"
WORKFLOWS_HOVER_LOCATION_ICON_TEXT = "//div[contains(@class,'popover-content') and contains(text(), 'Alerts by Specific Location')]"
WORKFLOWS_LIST_LOCATION_PERMISSION = "//li[contains(@class,'ai-item ai-nochild')]//span[contains(@class,'text')]"
WORKFLOWS_ROW_LOCATION_PERMISSION = "//li[contains(@class,'ai-item ai-nochild')]"
WORKFLOWS_LOCATION_FIRST_CHECKBOX = "//ul[contains(@class,'ai-list')]//child::li[contains(@class,'ai-item ai-nochild') and not(contains(@style,'display: none;'))][1]//div[contains(@class,'custom-checkbox')]//span"
WORKFLOWS_PATTERN_LOCATION_CHECKBOX = "//ul[contains(@class,'ai-list')]//child::li[contains(@class,'ai-item ai-nochild') and not(contains(@style,'display: none;'))]//span[contains(text(), '{}')]//parent::label//parent::div//child::div[contains(@class,'custom-checkbox')]//span"
WORKFLOWS_PATTERN_LOCATION_CHECKBOX_INDEX = "//ul[contains(@class,'ai-list')]//child::li[contains(@class,'ai-item ai-nochild') and not(contains(@style,'display: none;'))][{}]//div[contains(@class,'custom-checkbox')]//span"
WORKFLOWS_LOCATION_SEARCH_INPUT = "//input[contains(@aria-label,'Search for location')]"
WORKFLOWS_LOCATION_APPLY_BUTTON = "//button[contains(text(),'Apply')]"
WORKFLOWS_LIST_LOCATION_PERMISSION_TEXT = "//ul[contains(@class,'ai-list')]//child::li[contains(@class,'ai-item ai-nochild') and not(contains(@style,'display: none;'))]//span[contains(@class,'text')]"

# BASE PAGE (EXCEPT ROLE ADMIN)
CANDIDATE_REQUEST_ALERT_SECTION = "//div[contains(@class,'alert-row alert-experience-request')]"
CANDIDATE_REQUEST_ALERT_TITLE = "//div[contains(@class,'alert-row alert-experience-request')]//h3[contains(text(),'Candidate Request Alerts')]"
CANDIDATE_REQUEST_ALERT_DESCRIPTION = "//div[contains(@class,'alert-row alert-experience-request')]//descendant::div[contains(@class,'alert-text') and contains(text(),'Choose the candidate topics that will trigger alerts.')]"
CANDIDATE_REQUEST_ALERT_TOGGLE = "//div[contains(@class,'alert-row alert-experience-request')]/descendant::div[contains(@class,'alert-toggle')]"
CANDIDATE_RATING_ALERT_SECTION = "//div[contains(@class,'alert-row alert-experience-ratings')]"
CANDIDATE_RATING_ALERT_TITLE = "//div[contains(@class,'alert-row alert-experience-ratings')]//h3[contains(text(),'Candidate Rating Alerts')]"
CANDIDATE_RATING_ALERT_DESCRIPTION = "//div[contains(@class,'alert-row alert-experience-ratings')]//descendant::div[contains(@class,'alert-text') and contains(text(),'Receive an email alert to')]"
CANDIDATE_RATING_ALERT_TOGGLE = "//div[contains(@class,'alert-row alert-experience-ratings')]//descendant::div[contains(@class,'alert-toggle')]//child::label"
WORKFLOW_ALERT_TOGGLE = "//*[contains(text(),'Workflow Alerts')]//following-sibling::div//descendant::label"
ALERT_MANAGEMENT_SAVE_BUTTON = "//button[contains(text(), 'Save')]"

# BASE PAGE / CAMPUS APPROVALS
ALERT_MANAGEMENT_INPUT_USERS_BUTTON = "//input[@id='users-alerts']"
ALERT_MANAGEMENT_USER_TEXT = "//*[contains(@class,'info')]//*[contains(text(),'{}')]"
ALERT_MANAGEMENT_CLOSE_USER_BUTTON = "//*[contains(text(),'{}')]//parent::div//following-sibling::div//*[contains(@class,'remove-item')]"
