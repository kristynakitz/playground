*** Settings ***
Documentation        "Basic tests for Cell Phones product category on eBay"

Resource              resource.robot
Resource              testdata.robot

Suite Setup           Testsuite Setup
Suite Teardown        Close Browser

*** Test Cases ***

Open Website And Check Title
    [Documentation]      Opens the web browser and checks if proper website has been opened
    Title Should Start With        &{TEST_DATA}[title]

Search Box Is Present
    [Documentation]      Search box exists in given website
    Search Box Exists    ${search_id}

Search For Category
    [Documentation]     Search for category and check it contains the products
    Input Text to Searchbox and Press Enter   ${search_id}        ${category_name}
    Check Number Of Products Listed               ${products_count_class}
    ${products_count}=      Get Number Of Product Items   ${products_count_class}
    Set Global Variable   ${products_count}


User Can Filter Products - Mark Checkbox
    [Documentation]    Mark checkbox can be checked and check if data has been filtered
    Select First Checkbox And Check If Selected
    Check Number Of Products Listed    ${products_count_class}
    Check Data Filtered  ${products_count_class}


User Can Filter Products - Deselect Checkbox
    [Documentation]    Deselect checkbox and check if data has been filtered
    Deselect Checkbox And Chek If Unselected
    Check Number Of Products Listed    ${products_count_class}
    Check Data Filtered     ${products_count_class}


#User Can Filter Products - Radio buttons
#    [Documentation]    Checks whether radio buttons can be switched


#User Can Filter Products - TextField
#    [Documentation]    Checks whether procucts can be filtered by text fields


Select Buy It Now Products
    [Documentation]  Click Buy It Now filter and checks that all products has Buy It Now option
    Select Buy It Now Products


# This section tests the category selection from menu
Go To HomePage
    [Documentation]    Go to HomePage to perform the next tests
    Go To     &{TEST_DATA}[url]
    Title Should Start With        &{TEST_DATA}[title]


Click Category From Menu
    [Documentation]     Click Electronics category in main page
    Select Category From Menu    ${cat_locator}
    Select SubCategory     ${subcat_locator}


Click Subcategory From Menu
    [Documentation]    Click Cellphones category
    Wait Until Page Contains Element   ${cellphones_locator}
    Select SubCategory    ${cellphones_locator}


Select Cell Phones Category
    [Documentation]    Click Shop Cellphones
    Select SubCategory    ${cellphones_sub_loc}
    Wait Until Page Contains Element  class:${filter_count}
    Check Number Of Products Listed        ${filter_count}





