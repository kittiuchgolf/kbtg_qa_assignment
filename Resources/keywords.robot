*** Settings ***
Documentation       Keywords for test functions

Library             RPA.Browser.Selenium.Selenium
Library             Collections
Resource            productDetail.robot


*** Variables ***
${inputSearch}              id=autocomplete-0-input
${autoSuggestSection}       id=autocomplete-0-list
${firstItemInList}          css:#product-list > div > div > ol > li:nth-child(1)
${sorry}                    css:.sorry
${sortingDropdownlist}      css=.FilterDropdownView__StyledContainer-sc-jvuug9-0.sort-dropdown.filter-dropdown
${CSS_Selector}             .finalPrice


*** Keywords ***
Open website
    Open Available Browser    ${WEBSITE_URL}
    Location Should Be    ${WEBSITE_URL}
    Maximize Browser Window

Search for keywords
    [Arguments]    ${item}
    Click Element    ${inputSearch}
    Input Text    ${inputSearch}    ${item}
    Sleep    4s
    Location Should Contain    search

Verify product detail
    [Arguments]    ${item}
    Verify auto suggestions button    ${item}
    Click on first item
    Verify product detail page for searched item    ${item}

Verify Unavailable product detail
    Click on first item
    Verify product detail page for unavailable item

Verify non-exist product
    Wait Until Element Is Visible    ${sorry}
    ${item_text}    Get Text    ${sorry}
    Should Contain    ${item_text}    ${SORRY_TEXT}

Verify auto suggestions button
    [Arguments]    ${expectedItem}
    Wait Until Element Is Visible    ${autoSuggestSection}
    ${items}    Get WebElements    css:.aa-List li
    FOR    ${item}    IN    @{items}
        ${item_text}    Get Text    ${item}
        Should Contain    ${item_text}    ${expectedItem}    ignore_case=True
    END

Click on first item
    Element Should Be Visible    ${firstItemInList}    error=first item not found
    Click Element    ${firstItemInList}

Click on sort dropdown list
    Click Element    ${sortingDropdownlist}

Select Recommended for Sorting
    Click Element by Data Value    cds_en_products_recommened_sort_order_desc

Select New Arrivals for Sorting
    Click Element by Data Value    cds_en_products_created_at_desc

Select Price Low to High for Sorting
    Click Element by Data Value    cds_en_products_final_price_asc

Select Price High to Low for Sorting
    Click Element by Data Value    cds_en_products_final_price_desc

Select Discount Low to High for Sorting
    Click Element by Data Value    cds_en_products_discount_percentage_asc

Select Discount High to Low for Sorting
    Click Element by Data Value    cds_en_products_discount_percentage_desc

Select Most Reviews for Sorting
    Click Element by Data Value    cds_en_products_rating_count_desc

Click Element by Data Value
    [Arguments]    ${value}
    ${xpath}    Set Variable    //span[@data-value='${value}']
    Wait Until Element Is Visible    ${xpath}
    Click Element    ${xpath}

Verify items is sorted by Price from Low to High
    Sleep    2s
    ${finalPrices}    Extract Final Prices
    ${gobu}    Check If List Is Sorted    ${finalPrices}

Extract Final Prices
    ${prices}    Create List
    FOR    ${index}    IN RANGE    1    6
        ${price}    Get Text
        ...    css=#product-list > div > div > ol > li:nth-child(${index}) > div > div > div.sliderText > div.productPrice > div > h4
        Append To List    ${prices}    ${price}
    END
    RETURN    ${prices}

Check If List Is Sorted
    [Arguments]    ${input_list}
    ${reverted_sorted_list}    Copy List    ${input_list}
    Sort List    ${reverted_sorted_list}
    ${is_sorted}    Evaluate    ${input_list} == ${reverted_sorted_list}
    RETURN    ${is_sorted}
