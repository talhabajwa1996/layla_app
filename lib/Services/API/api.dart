import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:layla_app_dev/Utils/Globals.dart';
import 'app_exceptions.dart';

class GraphqlApi {
  static GraphQLClient? _graphQLClient;
  static const String apiUrl =
      '$storeUrl/api/$storefrontApiVersion/graphql.json';

  static void config() {
    _graphQLClient = GraphQLClient(
      link: HttpLink(
        apiUrl,
        defaultHeaders: {
          'X-Shopify-Storefront-Access-Token': storefrontAccessToken,
        },
      ),
      cache: GraphQLCache(),
    );
  }

  static Future<dynamic> query(String query,
      {Map<String, dynamic>? variables}) async {
    try {
      final WatchQueryOptions options = WatchQueryOptions(
          document: gql(query),
          variables: variables ?? {},
          fetchPolicy: FetchPolicy.noCache);
      final QueryResult response = await _graphQLClient!.query(options);
      debugPrint("Response: ${response.data}");
      if (response.hasException) {
        throw Exception(response.exception!.graphqlErrors.first.message);
      }
      return response.data;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
  }

  static Future<dynamic> mutation(
      String mutation, Map<String, dynamic> variables) async {
    try {
      final MutationOptions options = MutationOptions(
          document: gql(mutation),
          variables: variables,
          fetchPolicy: FetchPolicy.noCache);
      print(options.variables.toString());
      final QueryResult response = await _graphQLClient!.mutate(options);
      debugPrint("Response: ${response.data}");
      if (response.hasException) {
        throw Exception(response.exception!.graphqlErrors.first.message);
      }
      return response.data;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    } catch (e) {
      throw Exception(e);
    }
  }
}
