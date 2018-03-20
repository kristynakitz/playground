*** Settings ***
Documentation     A resource file with test data
Library           Collections

*** Variables ***
${eshop_url}               ebay.com
${expected_title}          eBay
${search_id}               gh-ac
${products_count_class}    rcnt

# Menu
${category_name}        Cell Phones
${cat_locator}          xpath://div[@id="navigationFragment"]/descendant::a[text()="Electronics"]
${subcat_locator}       xpath://div[@class="sub-cats"]/descendant::a[contains(text(), "Cell Phones")]
${cellphones_locator}   xpath://a[contains(text(), "Cellphones & Smartphones")]
${cellphones_sub_loc}   xpath://a[contains(text(), "Shop")]


# Facets for Operating System
${facet_label}          Operating System
${os_id}                e1-66
${checkbox}             xpath://div[@id="${os_id}"]//input
${checkbox_text_attr}   aria-label
${data_aspect_attr}     data-aspecttitle

# Facets for Buy it Now
${buy_it_now}           xpath://a[@title="Buy It Now"]
${res_id}               ResultSetItems


${filter_count}         listingscnt



*** Keywords ***
Create Test Data
     &{TEST_DATA}      Create Dictionary  url=http://${eshop_url}   title=${expected_title}
     Set Global Variable   &{TEST_DATA}





