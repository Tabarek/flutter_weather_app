import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCalls with ChangeNotifier {
  static const basedURL = 'https://api.openweathermap.org/data/2.5/';
  String apiKey = '10b0f8c26972b222a16b5bf62308ba27';

  Map<String, dynamic> result = {};
  static int timeoutDuration = 60;

  /*---------------------------- HTTP ------------------------------*/
  Future<Map<String, dynamic>> apiReq(String endPoint) async {
    final Uri url = Uri.parse('$basedURL/$endPoint=$apiKey');

    http.Response response;

    try {
      response =
          await http.get(url).timeout(Duration(seconds: timeoutDuration));

      notifyListeners();

      if (response.statusCode == 200) {
        result = {
          "resCode": 200,
          "resData": response.body,
        };
      } else {
        result = {
          "resCode": 500,
          "resData": response.body,
        };
      }
    } on SocketException catch (_) {
      result = {
        "resCode": 600,
        "resData": "No internet connection",
      };
    } on TimeoutException catch (_) {
      result = {
        "resCode": 600,
        "resData": "Request time has expired, please try again later",
      };
    } catch (e) {
      result = {
        "resCode": 600,
        "resData": "Error occurred, request could not be send",
      };
    }

    return result;
  }
}
