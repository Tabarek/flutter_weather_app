import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/api/api_call.dart';
import 'package:weather/locator.dart';
import 'package:weather/models/current_weather.dart';
import 'package:weather/utils/colors.dart';
import 'package:weather/utils/toast.dart';

class CurrentWeatherContr with ChangeNotifier {
  List<ListElement>? _list;
  City? _city;
  bool _isWeatherFetched = false;

  get list => _list;
  get city => _city;
  get isWeatherFetched => _isWeatherFetched;

  Future fetchCurrentWeather({String? langCode}) async {
    ApiCalls _apiCall = locator<ApiCalls>();

    String endPoint = 'forecast?q=Baghdad&lang=$langCode&units=metric&APPID';
    try {
      _isWeatherFetched = true;
      notifyListeners();

      var response = await _apiCall.apiReq(endPoint);

      _isWeatherFetched = false;
      notifyListeners();

      if (response['resCode'] == 200) {
        var decodeResp = currentWeatherModelFromJson(response['resData']);

        _list = decodeResp.list;
        notifyListeners();
        _city = decodeResp.city;
        notifyListeners();
      } else {
        var decodeResp = json.decode(response['resData']);
        toast(msg: decodeResp['message'], backgroundColor: error);
      }
    } catch (e) {
      toast(msg: e.toString(), backgroundColor: error);

      print(e.toString());
    }
  }
}
