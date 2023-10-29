
fetchMenuItem(String menuItemId){
  const String menuItemResources = r'''
    menuItem(id: $menuItemId) {
        linkedResource {
          __typename
          ... on Product {
            title
          }
          ... on Collection {
            title
          }
        }
      }
  ''';
  return menuItemResources;
}
