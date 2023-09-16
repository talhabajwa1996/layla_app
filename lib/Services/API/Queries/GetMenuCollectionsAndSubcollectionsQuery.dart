const String menuCollectionsAndSubCollectionsQuery = r'''{
    menu(handle: "main-menu"){
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