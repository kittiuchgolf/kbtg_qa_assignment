*** Settings ***
Documentation       Keywords for test functions

Library             RPA.Browser.Selenium.Selenium
Resource            productDetail.robot


*** Variables ***
${inputSearch}              id=autocomplete-0-input
${autoSuggestSection}       id=autocomplete-0-list
${firstItemInList}          css:#product-list > div > div > ol > li:nth-child(1)
${sorry}                    css:.sorry


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
