const String getProductsByCollection = r'''
    query GetProductsByCollection($collectionHandle: String!) {
      collectionByHandle(handle: $collectionHandle) {
    products(first: 100) {
      edges {
        node {
          createdAt
          id
          title
          description
          availableForSale
          compareAtPriceRange{
              minVariantPrice{
                  amount
                  currencyCode
              }
          }
          images(first: 10) {
                edges {
                  node {
                    originalSrc
                    altText
                  }
                }
              }
          priceRange {
            minVariantPrice {
              amount
              currencyCode
            }
          }
          options(first: 10){
              name
              values
          }
        }
      }
    }
      }
    }
  ''';
