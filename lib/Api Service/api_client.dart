import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import '../utils/tmdb_api_key.dart';

class ApiClient extends GetxService {
   String appBaseUrl;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;
  String? token;
  Map<String, String> _mainHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': "*",
  };

  ApiClient({this.appBaseUrl = baseUrl});
  void updateHeader(
    String token,
  ) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      final url = Uri.parse(appBaseUrl + uri);
      final urlWithParameters = url.replace(queryParameters: query);
      http.Response response = await http.get(
        urlWithParameters,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse( response,urlWithParameters.toString(),);
    } catch (e) {
      if (kDebugMode) {
        print("error : $e");
      }
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final url = Uri.parse(appBaseUrl + uri);
      http.Response response = await http.post(
        url,
        body: jsonEncode(body) ,
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse( response,url.toString());
    } catch (e) {
      if (kDebugMode) {
        print("error$e");
      }
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }



  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final url = Uri.parse(appBaseUrl + uri);
      http.Response response = await http.put(
        url,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse( response,url.toString());
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, dynamic>? query,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse(appBaseUrl + uri);
      final urlwithparameters = url.replace(queryParameters: query);
      http.Response response = await http.delete(
        urlwithparameters,
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response,url.toString());
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    if (_response.statusCode != 200 && _response.body == null) {
      _response = const Response(statusCode: 0, statusText: noInternetMessage);
    }
    print(
        '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    return _response;
  }
}
