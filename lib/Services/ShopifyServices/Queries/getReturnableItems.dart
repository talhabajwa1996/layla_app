const String getReturnableItems = r'''
    query returnableFulfillmentsQuery($orderId: ID!) {
      returnableFulfillments(orderId: $orderId, first: 10) {
        edges {
          node {
            id
            fulfillment {
              id
            }
            returnableFulfillmentLineItems(first: 10) {
              edges {
                node {
                  fulfillmentLineItem {
                    id
                    lineItem{
                      
                currentQuantity
                discountAllocations {
                  allocatedAmount {
                    amount
                    currencyCode
                  }
                }
                discountedTotal
                originalTotal
                quantity
                title
                image {
                    altText
                    id
                    originalSrc
                  }
                variant {
                  price 
                  title
                  image {
                    altText
                    id
                    originalSrc
                  }
                  compareAtPrice
                  weight
                  weightUnit
                  availableForSale
                  sku
                  requiresShipping
                  id
                }
              
          }
            
                  }
                  quantity
                }
              }
            }
          }
        }
      }
    }
  ''';
