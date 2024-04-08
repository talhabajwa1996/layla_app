import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../../Utils/Globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'app_exceptions.dart';

class Api {
  static const String _apiUrl = 'https://api.laylacollection.com';

  static Future<dynamic> getRequestData(String apiEndPoint) async {
    String apiAddress = _apiUrl + apiEndPoint;
    debugPrint("URL: $apiAddress");
    var responseJson;
    try {
      String token = globals.accessToken;
      debugPrint(token);
      final response = await http.get(
        Uri.parse(apiAddress),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint("GET API RESPONSE: ===================${response.body}");
      responseJson = _returnListResponse(response);
      return responseJson;
    } on SocketException {
      debugPrint('Socket Exception');
      throw FetchDataException("No Internet Available");
    }
  }

  static Future<dynamic> postRequestData(
      String apiEndPoint, Map<String, dynamic> body,
      {bool sendToken = true}) async {
    String apiAddress = _apiUrl + apiEndPoint;
    debugPrint("URL: $apiAddress");
    var responseJson;
    try {
      String token = globals.accessToken;
      debugPrint('POST API Request -------------------------: $body');
      var response = await http
          .post(Uri.parse(apiAddress), body: jsonEncode(body), headers: {
        'x-access-token': token,
      });
      responseJson = _returnListResponse(response);
      debugPrint(
          'POST API Response -------------------------: ${response.body}');
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
  }

  static Future<dynamic> putRequestData(
      String apiEndPoint, Map<String, dynamic> body,
      {bool sendToken = true}) async {
    String apiAddress = _apiUrl + apiEndPoint;
    debugPrint("URL: $apiAddress");
    var responseJson;
    try {
      String token = globals.accessToken;
      debugPrint('PUT API Request -------------------------: $body');
      var response = await http.put(
        Uri.parse(apiAddress),
        body: jsonEncode(body),
        headers: sendToken
            ? {
                'Content-type': 'application/json',
                'Authorization': 'Bearer $token',
              }
            : {
                'Content-type': 'application/json',
              },
      );
      responseJson = _returnListResponse(response);
      debugPrint(
          'PUT API Response -------------------------: ${response.body}');
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
  }

  static Future<dynamic> multiPartRequestSingleFile(
      String apiEndPoint, Map<String, dynamic>? body,
      {String? fileKey, File? file}) async {
    String apiAddress = _apiUrl + apiEndPoint;
    debugPrint("URL: $apiAddress");
    var responseJson;
    try {
      String token = globals.accessToken;
      var request = http.MultipartRequest("POST", Uri.parse(apiAddress));
      request.headers.addAll({
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (file != null) {
        var media = await http.MultipartFile.fromPath(fileKey!, file.path);
        request.files.add(media);
      }
      body!.forEach((key, value) => request.fields[key] = value);
      debugPrint(
          'FORMDATA API Request -------------------------: ${request.fields}');
      http.Response response =
          await http.Response.fromStream(await request.send());
      debugPrint(
          'FORMDATA API Response -------------------------: ${response.body}');
      responseJson = _returnListResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Available");
    }
  }
}

dynamic _returnListResponse(http.Response response) {
  debugPrint(response.statusCode.toString());
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw UnauthorisedException(response.body.toString());
    case 404:
      throw RequestNotFoundException(response.body.toString());
    case 403:
      throw UnautorizationException(response.body.toString());
    case 500:
      throw InternalServerException(response.body.toString());
    case 503:
      throw ServerNotFoundException(response.body.toString());
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
