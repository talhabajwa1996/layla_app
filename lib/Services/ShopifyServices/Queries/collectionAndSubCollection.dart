const String menuCollectionsAndSubCollectionsQuery = r'''{
    menu(handle: "mobile-menu"){
        items{
            title
            type
            url
            id
            items {
                id
                title
                url
                type
            }
        }
        handle
        title
    }
}''';