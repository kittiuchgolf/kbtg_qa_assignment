*** Settings ***
Documentation       Template robot main suite.s

Library             RPA.Browser.Selenium.Selenium
Resource            ../Resources/keywords.robot


*** Tasks ***
Verify Search function and Prodcut Detail
    Open website
    Search for keywords    ${NORMAL_PRODUCT}
    Verify product detail    ${NORMAL_PRODUCT}

Verify Search function and Prodcut Detail (Unavailable Product)
    Open website
    Search for keywords    ${UNAVAILABLE_PRODUCT}
    Verify Unavailable product detail

Verify Search function for non-exist product
    Open website
    Search for keywords    ${NON_EXIST_PRODUCT}
    Verify non-exist product

Verify Search function for non-exist product
    Open website
    Search for keywords    ${NON_EXIST_PRODUCT}
    Verify non-exist product
