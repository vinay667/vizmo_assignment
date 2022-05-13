import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vizmo_assignment/utils/constants.dart';
import 'app_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = Constants.baseUrl;

  Future<http.Response> get(String url, BuildContext context) async {
    http.Response responseJson;
    print('url ${_baseUrl + url}');
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url.trim()), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      });
      responseJson = _returnResponse(response, context);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response, BuildContext context) {
    var responseJson = response;
    switch (response.statusCode) {
      case 200:
        print(responseJson);
        return responseJson;
      case 201:
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        Navigator.pop(context);
        throw BadRequestException(response.body.toString());
        break;
      case 403:
        Navigator.pop(context);
        throw UnauthorisedException(response.body.toString());
      case 500:
        Navigator.pop(context);
        break;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
