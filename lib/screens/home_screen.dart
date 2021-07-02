import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import 'package:weather/controllers/current_weather.dart';
import 'package:weather/locale/app_lang.dart';
import 'package:weather/locale/applocalization.dart';
import 'package:weather/models/current_weather.dart';
import 'package:weather/models/lang.dart';
import 'package:weather/screens/next_week.dart';
import 'package:weather/utils/colors.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/utils/images.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _langValue = 'en';
  List<ListElement>? _list;
  City? _city;

  double weatherHeight = 0.0;
  double heatHeight = 0.0;

  List<LangModel> langList = [
    LangModel(icon: '🇺🇸 English', value: 'en'),
    LangModel(icon: '🇮🇶 العربية', value: 'ar'),
  ];

  /// Used to convert timeStamp to formatted hours with AM or PM
  String? _timeFormatter(int? timestamp, [int index = 0]) {
    final format = intl.DateFormat.jm();
    return format
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000))
        .toString();
  }

  /// Localization
  String locale(String key) {
    return AppLocalizations.of(context)!.translate(key);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CurrentWeatherContr>(context, listen: false)
          .fetchCurrentWeather(langCode: _langValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    var appLanguage = Provider.of<AppLanguage>(context);
    CurrentWeatherContr provider = Provider.of<CurrentWeatherContr>(context);

    _list = provider.list;
    _city = provider.city;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            _list?[0].sys.pod == Pod.N ? darkGrey : Colors.blue.shade100,
        elevation: 0.0,
        title: Text(
          locale('title'),
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: DropdownButton(
              underline: SizedBox(),
              icon: CircleAvatar(
                backgroundColor: lightWhite,
                child: Text(_langValue == 'ar' ? '🇮🇶' : '🇺🇸'),
              ),
              items: langList.map((LangModel item) {
                return DropdownMenuItem(
                    value: item.value, child: Text(item.icon!));
              }).toList(),
              onChanged: (String? value) {
                print(value);
                setState(() {
                  _langValue = value;
                });

                appLanguage.changeLanguage(Locale("$_langValue"));
                AppLocalizations.of(context)!.load(Locale("$_langValue"));
              },
            ),
          ),
        ],
      ),
      body: provider.isWeatherFetched
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: _list?[0].sys.pod == Pod.N

                          /// Night colors
                          ? [
                              darkGrey,
                              navy,
                            ]

                          /// Day colors
                          : [
                              Colors.blue.shade100,
                              Colors.blue.shade200,
                            ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* --------------------- TODAY WEATHER --------------------*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _list?[0].sys.pod == Pod.N &&
                                    _list?[0].weather[0].main == MainEnum.CLEAR
                                ? nightClearImg

                                ///
                                : _list?[0].sys.pod == Pod.N &&
                                        _list?[0].weather[0].main !=
                                            MainEnum.CLEAR
                                    ? nightCloudImg

                                    ///
                                    : _list?[0].sys.pod == Pod.D &&
                                            _list?[0].weather[0].main ==
                                                MainEnum.CLEAR
                                        ? sunnyImg

                                        ///
                                        : cloudyImg,
                            height: screenSize.height * 0.07,
                          ),
                          SizedBox(
                            width: screenSize.width * 0.02,
                          ),
                          Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('today'),
                                style: TextStyle(
                                    color: white,
                                    fontSize: screenSize.height * 0.03),
                              ),
                              Text(
                                '${DateTime.now()}'.substring(0, 10),
                                style: TextStyle(
                                    color: white,
                                    fontSize: screenSize.height * 0.015,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ],
                      ),

                      /* ------------------------ TEMPERATURE ----------------------*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_list?[0].main.temp.round()} ',
                            style: TextStyle(
                                color: white,
                                fontSize: screenSize.height * 0.1),
                          ),
                          Text(
                            '֯C',
                            style: TextStyle(
                                color: white,
                                fontSize: screenSize.height * 0.05,
                                fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      /* ------------------------ LOCATION ------------------------*/
                      Text(
                        '${_langValue == 'en' ? _city?.name : locale('city')}, ${_langValue == 'en' ? _city?.country : locale('country')}',
                        style: TextStyle(
                            color: white, fontSize: screenSize.height * 0.015),
                      ),

                      /* ------------------------ FEELS LIKE -----------------------*/
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '${locale('feels_like')} ${_list?[0].main.feelsLike.round()}    •   ${locale('sunset')} ${_timeFormatter(_city?.sunset ?? 0)}',
                          style: TextStyle(
                              color: white,
                              fontSize: screenSize.height * 0.015),
                        ),
                      ),

                      /* ------------------------ DAYS LIST ------------------------*/
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              locale('today'),
                              style: TextStyle(
                                  color: white,
                                  fontSize: screenSize.height * 0.02),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              locale('tomorrow'),
                              style: TextStyle(
                                  color: white,
                                  fontSize: screenSize.height * 0.02),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    locale('next_week'),
                                    style: TextStyle(
                                        color: lightBlue,
                                        fontSize: screenSize.height * 0.02),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: lightBlue,
                                    size: screenSize.height * 0.02,
                                  ),
                                ],
                              ),
                              onTap: () => Get.to(() => NextWeekScreen(
                                    pod: _list?[0].sys.pod,
                                    locale: _langValue,
                                  )),
                            ),
                          ],
                        ),
                      ),

                      /*---------------------- WEATHER IN HOURS --------------------*/
                      Expanded(
                          flex: 1,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.03),
                              scrollDirection: Axis.horizontal,
                              itemCount: _list?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color:
                                          index == 0 ? Colors.white30 : black12,
                                      borderRadius: BorderRadius.circular(50)),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  height: screenSize.height * 0.035,
                                  width: screenSize.width / 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${_timeFormatter(_list?[index].dt ?? 0, index)}',
                                        style: TextStyle(
                                            color: lightWhite,
                                            fontSize: screenSize.height * 0.018,
                                            fontWeight: FontWeight.w200),
                                      ),
                                      Image.asset(
                                        _list?[index].sys.pod == Pod.N &&
                                                _list?[index].weather[0].main ==
                                                    MainEnum.CLEAR
                                            ? nightClearImg

                                            ///
                                            : _list?[index].sys.pod == Pod.N &&
                                                    _list?[index]
                                                            .weather[0]
                                                            .main !=
                                                        MainEnum.CLEAR
                                                ? nightCloudImg

                                                ///
                                                : _list?[index].sys.pod ==
                                                            Pod.D &&
                                                        _list?[index]
                                                                .weather[0]
                                                                .main ==
                                                            MainEnum.CLEAR
                                                    ? sunnyImg

                                                    ///
                                                    : cloudyImg,
                                        height: screenSize.height * 0.04,
                                      ),
                                      Text(
                                        '${_list?[index].main.temp.round()} ֯C',
                                        style: TextStyle(
                                            color: lightWhite,
                                            fontSize: screenSize.height * 0.025,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                );
                              })),

                      /*---------------------- HEAT LEVEL --------------------*/
                      SizedBox(
                        width: screenSize.width,
                        child: Text(
                          locale('level_of_heat'),
                          style: TextStyle(
                              color: white, fontSize: screenSize.height * 0.02),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '🔥',
                                    style: TextStyle(
                                        color: lightWhite,
                                        fontSize: screenSize.height * 0.02),
                                  ),
                                  Text(
                                    '☀️',
                                    style: TextStyle(
                                        color: lightWhite,
                                        fontSize: screenSize.height * 0.02),
                                  ),
                                  Text(
                                    '❄️',
                                    style: TextStyle(
                                        color: lightWhite,
                                        fontSize: screenSize.height * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: screenSize.width * 0.05,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.03),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _list?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: screenSize.height * 0.04,
                                        width: screenSize.width * 0.15,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height:
                                                  screenSize.height.round() *
                                                          0.08 +
                                                      _list![index]
                                                          .main
                                                          .temp
                                                          .round(),
                                              width: screenSize.width * 0.04,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: heatHeight > 100
                                                      ? Colors.deepOrangeAccent
                                                      : Colors.orange),
                                            ),
                                            Text(
                                              '${_timeFormatter(_list?[index].dt ?? 0, index)}',
                                              style:
                                                  TextStyle(color: lightWhite),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
