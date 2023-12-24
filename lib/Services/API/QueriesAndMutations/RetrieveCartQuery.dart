const String retrieveCartQuery = r'''query GetCart($cartId: ID!) {
  cart(
    id: $cartId) {
    id
    createdAt
    updatedAt
    lines(first: 100) {
      nodes {
        id
        quantity
        cost{
            totalAmount{
                amount
                currencyCode
            }
        }
        merchandise {
          ... on ProductVariant {
            id
            title
            product {
              title
              description
              id
            }
            price {
              amount
              currencyCode
            }
            image{
                url
            }
            selectedOptions {
              name
              value
            }
          }
        }
      }
    }

    cost {
      totalAmount {
        amount
        currencyCode
      }
      subtotalAmount {
        amount
        currencyCode
      }
      totalTaxAmount {
        amount
        currencyCode
      }
      totalDutyAmount {
        amount
        currencyCode
      }
    }
  }
  
}''';
