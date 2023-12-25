*** Settings ***
Documentation       Template robot main suite.s

Library             RPA.Browser.Selenium.Selenium
Resource            ../Resources/keywords.robot


*** Tasks ***
Verify Search function and Prodcut Detail
    [Setup]    Open website
    Search for keywords    ${NORMAL_PRODUCT}
    Verify product detail    ${NORMAL_PRODUCT}
    [Teardown]    Close Browser

Verify Search function and Prodcut Detail (Unavailable Product)
    [Setup]    Open website
    Search for keywords    ${UNAVAILABLE_PRODUCT}
    Verify Unavailable product detail
    [Teardown]    Close Browser

Verify Search function for non-exist product
    [Setup]    Open website
    Search for keywords    ${NON_EXIST_PRODUCT}
    Verify non-exist product
    [Teardown]    Close Browser

Verify Sorting function by Price Low to High
    [Setup]    Open website
    Search for keywords    ${NORMAL_PRODUCT}
    Click on sort dropdown list
    Select Price Low to High for Sorting
    Verify items is sorted by Price from Low to High
    [Teardown]    Close Browser
