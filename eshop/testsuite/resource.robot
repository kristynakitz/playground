*** Settings ***
Documentation     A resource file with reusable keywords and variables

Library           SeleniumLibrary
Library           String

Resource          testdata.robot

*** Variables ***
${BROWSER}        Firefox
${DELAY}          1   # it's slow connection from China


*** Keywords ***
Testsuite Setup
    Create Test Data
    Open Browser to Home Page


Open Browser to Home Page
    Open Browser              &{TEST_DATA}[url]  ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed        ${DELAY}


Title Should Start With
    [Arguments]       ${expected}
    ${title} =        Get Title
    Should Contain    ${title}  ${expected}  case_sensitive=False


Is Element Exists
    [Arguments]       ${element}
    ${count}=         Get Element Count    ${element}
    Should Be True    ${count} > 0


Search Box Exists
    [Arguments]         ${search_box_id}
    Is Element Exists   id:${search_box_id}


Input Text to Searchbox and Press Enter
    [Arguments]     ${search_box_id}    ${category_name}
    Input Text    id:${search_box_id}   ${category_name}
    Press Key     id:${search_box_id}   \\13


Get Number Of Product Items
    [Arguments]                          ${class_name}
    Wait Until Page Contains Element     class:${class_name}
    ${items_count}=               Get Text     class:${class_name}
    [Return]    ${items_count}


Check Number Of Products Listed
    [Arguments]       ${class_name}
    ${result}=     Get Number Of Product Items  ${class_name}
    @{res}=        Split String	  ${result}
    Should Be True                  @{res}[0] > 0


Check Data Filtered
    [Arguments]   ${class_name}
    ${result}=     Get Number Of Product Items  ${class_name}
    Should Be True   ${result} <= ${products_count}


Select Category From Menu
    [Arguments]           ${locator}
    Is Element Exists                    ${locator}
    ${elem}=                             Get WebElement      ${locator}
    Mouse Over                           ${elem}


Select SubCategory
    [Arguments]     ${locator}
    Is Element Exists                     ${locator}
    ${elem}=        Get WebElement        ${locator}
    Mouse Over      ${elem}
    Click Element   ${elem}

Select First Checkbox And Check If Selected
    ${ckx}=   Get Checkbox    ${checkbox}
    ${checkbox_text}=   Get Checkbox Label    ${ckx}
    Select Checkbox  ${ckx}
    Check If Checkbox Marked  ${ckx}  ${checkbox_text}


Deselect Checkbox And Chek If Unselected
    Deselect Checkbox
    Check If Checkbox Not Marked   ${checkbox}


Get Checkbox
   [Arguments]    ${checkbox}
   Is Element Exists    ${checkbox}
   @{elems}=    Get WebElements   ${checkbox}
   [Return]   @{elems}[0]


Get Checkbox Label
   [Arguments]    ${checkbox_element}
   ${checkbox_text}=      Get Element Attribute   ${checkbox_element}    attribute=${checkbox_text_attr}
   [Return]     ${checkbox_text}


Check If Checkbox Marked
   [Arguments]    ${checkbox_element}     ${checkbox_label}
   Wait Until Page Contains Element    xpath://*[contains(@${data_aspect_attr}, "${facet_label}")]/../..
   Is Element Exists                   xpath://*[contains(@${data_aspect_attr}, "${facet_label}")]/../..
   ${id}=   Get Element Attribute      xpath://*[contains(@${data_aspect_attr}, "${facet_label}")]/../..   attribute=id
   Is Element Exists                   xpath://*[@id="${id}"]/descendant::input[contains(@${checkbox_text_attr}, ${checkbox_label})]
   ${selected_elem}=  Get WebElement   xpath://*[@id="${id}"]/descendant::input[contains(@${checkbox_text_attr}, ${checkbox_label})]
   Checkbox Should Be Selected   ${selected_elem}


Deselect Checkbox
    ${id}=   Get Element Attribute   xpath://*[contains(@${data_aspect_attr}, "${facet_label}")]/../..   attribute=id
    Is Element Exists    xpath://*[@id="${id}"]/descendant::input[@checked]
    ${elem}=  Get WebElement   xpath://*[@id="${id}"]/descendant::input[@checked]
    Checkbox Should Be Selected   ${elem}
    Unselect Checkbox   ${elem}


Check If Checkbox Not Marked
    [Arguments]    ${checkbox}
    ${ckx}=   Get Checkbox   ${checkbox}
    Checkbox Should Not Be Selected  ${ckx}


Select Buy It Now Products
     Is Element Exists   ${buy_it_now}
     ${elem}=    Get WebElement   ${buy_it_now}
     Click Element   ${elem}
     Wait Until Page Contains Element   xpath://div[@id="${res_id}"]
     Is Element Exists  xpath://div[@id="${res_id}"]/descendant::li[@listingid]
     @{elems}=    Get WebElements   xpath://div[@id="${res_id}"]/descendant::li[@listingid]/child::ul/li[@class="lvformat"]/span
     :FOR   ${e}   IN  @{elems}
     \  ${text}=   Get Text   ${e}
     \  Should Be Equal  ${text}   Buy It Now
















