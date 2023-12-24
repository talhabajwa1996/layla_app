String addItemToCartMutation =
    r'''mutation cartLinesAdd($cartId: ID!, $lines: [CartLineInput!]!) {
  cartLinesAdd(cartId: $cartId, lines: $lines) {
    cart {
        cost{
            checkoutChargeAmount{
                amount
                currencyCode
            }
        }
    }
    userErrors {
      field
      message
    }
  }
}''';
