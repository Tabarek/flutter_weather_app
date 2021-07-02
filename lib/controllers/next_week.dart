import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:weather/api/api_call.dart';
import 'package:weather/locator.dart';
import 'package:weather/models/next_week_w.dart';
import 'package:weather/utils/colors.dart';
import 'package:weather/utils/toast.dart';

class NextWeekWeatherContr with ChangeNotifier {
  List<Daily>? _dailyList;
  Current? _current;
  bool _isWeatherFetched = false;

  get dailyList => _dailyList;
  get current => _current;
  get isWeatherFetched => _isWeatherFetched;

  Future fetchNextWeekWeather({String? langCode}) async {
    ApiCalls _apiCall = locator<ApiCalls>();

    String endPoint =
        'onecall?lat=33.3152&lon=44.3661&exclude=hourly,minutely&units=metric&appid';
    try {
      _isWeatherFetched = true;
      notifyListeners();

      var response = await _apiCall.apiReq(endPoint);

      _isWeatherFetched = false;
      notifyListeners();

      if (response['resCode'] == 200) {
        var decodeResp = nextWeekWeatherModelFromJson(response['resData']);
        print(decodeResp);
        _dailyList = decodeResp.daily;
        notifyListeners();
        _current = decodeResp.current;
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
