import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather/controllers/next_week.dart';
import 'package:weather/locale/applocalization.dart';
import 'package:weather/models/current_weather.dart';
import 'package:weather/models/next_week_w.dart';
import 'package:weather/utils/colors.dart';
import 'package:weather/utils/images.dart';

class NextWeekScreen extends StatefulWidget {
  static const routeName = '/home_page/next_week';
  final Pod? pod;
  final String? locale;

  NextWeekScreen({this.pod, this.locale});

  @override
  _NextWeekScreenState createState() => _NextWeekScreenState();
}

class _NextWeekScreenState extends State<NextWeekScreen> {
  List<Daily>? _dailyList;
  Current? _current;

  /// Used to return english or arabic week day
  String weekDay(int timeStump, String locale) {
    String input = DateFormat('EEEE')
        .format(DateTime.fromMillisecondsSinceEpoch(timeStump * 1000));

    const englishDays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    const arabicDays = [
      'الاحد',
      'الاثنين',
      'الثلاثاء',
      'الاربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ];

    for (int i = 0; i < englishDays.length; i++) {
      input = locale == 'ar'
          ? input.replaceAll(englishDays[i], arabicDays[i])
          : input;
    }

    return input;
  }

  /// To translate texts
  String locale(String key) {
    return AppLocalizations.of(context)!.translate(key);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<NextWeekWeatherContr>(context, listen: false)
          .fetchNextWeekWeather();
    });
  }

  /// Day weather in row widget
  Widget nextDayInfo({
    var screenSize,
    String? nextDay,
    Widget? weatherStatus,
    String? key,
    String? info,
    String? key2,
    String? info2,
  }) {
    return Container(
      width: screenSize.width / 2.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nextDay!,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: screenSize.height * 0.025),
              ),
              weatherStatus!
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key!,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: screenSize.height * 0.016,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                info!,
                style: TextStyle(
                    color: Colors.grey, fontSize: screenSize.height * 0.016),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key2!,
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: screenSize.height * 0.016,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                info2!,
                style: TextStyle(
                    color: Colors.grey, fontSize: screenSize.height * 0.016),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NextWeekWeatherContr provider = Provider.of<NextWeekWeatherContr>(context);

    _dailyList = provider.dailyList;
    _current = provider.current;

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        elevation: 0.0,
        title: Text(
          locale('title'),
          style: TextStyle(
              fontWeight: FontWeight.w300, color: Colors.grey.shade700),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey.shade700),
      ),
      body: provider.isWeatherFetched
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                    width: screenSize.width,
                    child: Text(
                      locale('next_week'),
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: screenSize.height * 0.03),
                    ),
                  ),

                  /*-------------------- CARD WEATHER ----------------------*/
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          nextDayInfo(
                              screenSize: screenSize,
                              nextDay: weekDay(_current!.dt, widget.locale!),
                              weatherStatus: Image.asset(
                                widget.pod == Pod.N &&
                                        _current!.weather[0].main == 'Clear'
                                    ? nightClearImg

                                    ///
                                    : widget.pod == Pod.N &&
                                            _current!.weather[0].main != 'Clear'
                                        ? nightCloudImg

                                        ///
                                        : widget.pod == Pod.D &&
                                                _current!.weather[0].main ==
                                                    'Clear'
                                            ? sunnyImg

                                            ///
                                            : cloudyImg,
                                height: screenSize.height * 0.04,
                              ),
                              key: locale('wind'),
                              info: '${_current!.windSpeed}m/h',
                              key2: locale('visibility'),
                              info2: '${_current!.visibility} km'),

                          ///
                          nextDayInfo(
                              screenSize: screenSize,
                              nextDay: '${_current!.temp!.round()} ֯C',
                              weatherStatus: SizedBox(),
                              key: locale('humidity'),
                              info: '${_current!.humidity} %',
                              key2: locale('uv'),
                              info2: '${_current!.uvi}'),
                        ],
                      ),
                    ),
                  ),

                  /*----------------------- NEXT DAYS WEATHER -----------------------*/
                  Expanded(
                      child: ListView.builder(
                          padding:
                              EdgeInsets.only(top: screenSize.height * 0.05),
                          itemCount: _dailyList!.length,
                          itemBuilder: (cont, ind) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        weekDay(_dailyList![ind].dt,
                                            widget.locale!),
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: screenSize.height * 0.016,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '💧 ${_dailyList![ind].humidity}%',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: screenSize.height * 0.014,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    widget.pod == Pod.N &&
                                            _current!.weather[0].main == 'Clear'
                                        ? nightClearImg

                                        ///
                                        : widget.pod == Pod.N &&
                                                _current!.weather[0].main !=
                                                    'Clear'
                                            ? nightCloudImg

                                            ///
                                            : widget.pod == Pod.D &&
                                                    _current!.weather[0].main ==
                                                        'Clear'
                                                ? sunnyImg

                                                ///
                                                : cloudyImg,
                                    height: screenSize.height * 0.04,
                                  ),
                                  Text(
                                    '${_dailyList![ind].temp.min!.round()} ֯C',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenSize.height * 0.018,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    height: screenSize.height * 0.03,
                                    width: screenSize.width * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: _dailyList![ind].temp.min!,
                                          decoration: BoxDecoration(
                                              color: Colors.blue.shade100,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20))),
                                        ),
                                        Container(
                                          width: _dailyList![ind].temp.max!,
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${_dailyList![ind].temp.max!.round()}  ֯C',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: screenSize.height * 0.018,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
      backgroundColor: Colors.blue.shade50,
    );
  }
}
