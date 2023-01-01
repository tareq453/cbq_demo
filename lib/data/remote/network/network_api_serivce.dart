import 'dart:convert';
import 'dart:io';

import 'package:cbq/data/remote/AppException.dart';
import 'package:cbq/data/remote/network/base_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  //GET
  @override
  Future getResponse(
      {required String endpoint, Map<String, Object>? query}) async {
    print("endpoint 2 $endpoint");
    try {
      final uri = Uri.https(baseUrl, endpoint, query);
      print("endpoint 3 $endpoint");
      if (kDebugMode) {
        print(uri);
      }
      return returnResponse(await http.get(uri));
    } on SocketException {
      throw HttpException(message: 'No Internet Connection');
    }  catch (error) {
      rethrow;
    }
  }

  //POST
  @override
  Future postResponse(String endpoint, Map<String, dynamic>? data) async {
    if (kDebugMode) {
      print("post");
    }
    try {
      final uri = Uri.http(baseUrl, endpoint);
      if (kDebugMode) {
        print(uri);
      }
      return returnResponse(
        await http.post(uri, body: data),
      );
    } on SocketException {
      throw HttpException(message: 'No Internet Connection');
    }catch(error){
      rethrow;
    }

  }

  // PUT
  @override
  Future patchResponse(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.https(baseUrl, endpoint);
    if (kDebugMode) {
      print(uri);
    }
    return returnResponse(await http.patch(uri, body: data));
  }

  // DELETE
  @override
  Future deleteResponse({required String endpoint, required String id}) async {
    final String endPointUrl = id.isEmpty ? endpoint : '$endpoint/' '$id/';
    if (kDebugMode) {
      print(endPointUrl);
    }
    final uri = Uri.https(baseUrl, endPointUrl);
    if (kDebugMode) {
      print(uri);
    }
    return returnResponse(await http.delete(
      uri,
    ));
  }

  //function to process responses for all kind of requests - POST,PUT,DELETE,GET
  dynamic returnResponse(http.Response response) {
    print("statusCode ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        print("response.body ${response.body}");
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server'
            ' with status code : ${response.statusCode}');
    }
  }
}
