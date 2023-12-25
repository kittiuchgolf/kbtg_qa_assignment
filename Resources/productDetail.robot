*** Settings ***
Documentation       Template robot main suite.s

Library             RPA.Browser.Selenium.Selenium
Resource            ../Data/data.robot


*** Variables ***
${productTitle}                     css=.secondary-title_pdp
${productDescription}               css=.pdp-productDetail__desc
${productPrice}                     css=.productDetail__priceSell
${productSeller}                    css=.productDetail__productSeller
${the1Redeem}                       css=.productDetail__redeemWrapper
${productQuantityDropdown}          css=.productQuantityDropdown
${addToCartButton}                  css=.add-to-cart
${addToWishListButton}              css=.addToWishlist
${pictureSlider}                    css=.slick-slider
${unavailableProductSection}        id=404
${unavailableProductHeader}         css=#jkl > h1
${unavailableProductDescription}    css=#jkl2 > h5
${unavailableHeader}                Sorry. We couldn't find what you were looking for.
${unavailableDescription}           You can return to our homepage or might find something you love from our recommendations below.


*** Keywords ***
Verify product detail page for searched item
    [Arguments]    ${expectedItem}
    Location Should Contain    ${expectedItem}    ignore_case=True
    Verify title of product should include searched keywords    ${expectedItem}
    Verify description of product should include searched keywords    ${expectedItem}
    Verify product price should be found
    Verify product seller should be found
    Verify product quantity dropdown list should be found
    Verify add to cart button should be found
    Verify add to wishlist button should be found
    Verify product picture slider should be found

Verify product detail page for unavailable item
    Wait Until Element Is Visible    ${unavailableProductSection}
    ${elementText1}    Get Text    ${unavailableProductHeader}
    Should Be Equal As Strings    ${elementText1}    ${unavailableHeader}
    ${elementText2}    Get Text    ${unavailableProductDescription}
    Should Be Equal As Strings    ${elementText2}    ${unavailableDescription}

Verify title of product should include searched keywords
    [Arguments]    ${expectedItem}
    Expect element to contain text    ${productTitle}    ${expectedItem}

Verify description of product should include searched keywords
    [Arguments]    ${expectedItem}
    Expect element to contain text    ${productDescription}    ${expectedItem}

Verify product seller should be found
    Expect element to contain text    ${productSeller}    Sold by:

Verify product price should be found
    Wait Until Element Is Visible    ${productPrice}
    Element Should Be Visible    ${productPrice}

Verify the 1 point redemption should be found
    Wait Until Element Is Visible    ${the1Redeem}
    Element Should Be Visible    ${the1Redeem}

Verify product quantity dropdown list should be found
    Wait Until Element Is Visible    ${productQuantityDropdown}
    Element Should Be Visible    ${productQuantityDropdown}

Verify add to cart button should be found
    Wait Until Element Is Visible    ${addToCartButton}
    Element Should Be Visible    ${addToCartButton}

Verify add to wishlist button should be found
    Wait Until Element Is Visible    ${addToWishListButton}
    Element Should Be Visible    ${addToWishListButton}

Verify product picture slider should be found
    Wait Until Element Is Visible    ${pictureSlider}
    Element Should Be Visible    ${pictureSlider}

Expect element to contain text
    [Arguments]    ${elementLocator}    ${expectedText}
    Wait Until Element Is Visible    ${elementLocator}
    ${elementText}    Get Text    ${elementLocator}
    Should Contain    ${elementText}    ${expectedText}    ignore_case=True
