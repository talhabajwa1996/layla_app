const String createCardAndAddItemMutation =
    r'''mutation CartCreate($merchandiseId: ID!, $quantity: Int!) {
  cartCreate(
    input: {
      lines: [
        {
          quantity: $quantity
          merchandiseId: $merchandiseId
        }
      ],
    }
  ) {
    cart {
      id
      createdAt
      updatedAt
      lines(first: 10) {
        edges {
          node {
            id
            merchandise {
              ... on ProductVariant {
                id
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
    userErrors {
      field
      message
    }
  }
}
''';
