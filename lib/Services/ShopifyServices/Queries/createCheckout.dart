const String createCheckoutMutation =
    r'''mutation CreateCheckout($lineItems: [CheckoutLineItemInput!]!,$shippingAddress: MailingAddressInput!) {
  checkoutCreate(input: { lineItems: $lineItems, shippingAddress: $shippingAddress}) {
    checkout {
      id
      paymentDue{
        amount
        currencyCode
      }
      totalPrice{
        amount
        currencyCode
      }
      subtotalPrice{
        amount
        currencyCode
      }
      totalTax{
        amount
        currencyCode
      }
      availableShippingRates{
        ready
        shippingRates{
            title
            price{
                amount
                currencyCode
            }
        }
      }
      taxesIncluded
    }
    checkoutUserErrors {
      field
      message
    }
  }
}''';
