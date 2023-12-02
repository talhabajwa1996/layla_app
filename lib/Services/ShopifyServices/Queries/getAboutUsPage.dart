const String getAboutUsPageQuery = r'''{
    page(handle: "about-us"){
        handle
        id
        title
        body
        bodySummary
        createdAt
        onlineStoreUrl
    }
}''';
