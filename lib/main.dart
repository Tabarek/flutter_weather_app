import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'package:weather/controllers/current_weather.dart';
import 'package:weather/controllers/next_week.dart';
import 'package:weather/locale/app_lang.dart';
import 'package:weather/locale/applocalization.dart';
import 'package:weather/locator.dart';
import 'package:weather/screens/splash_screen.dart';
import 'package:weather/screens_route.dart';

void main() async {
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  setupLocator();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App(
      appLanguage: appLanguage,
    ));
  });
}

class App extends StatelessWidget {
  AppLanguage appLanguage;

  App({required this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentWeatherContr()),
        ChangeNotifierProvider(create: (_) => NextWeekWeatherContr()),
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
      ],
      child: GetMaterialApp(
        title: 'Weather Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Mukta',
        ),
        locale: appLanguage.appLocal,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: SplashScreen(),
        onGenerateRoute: ScreensRouter.generateRoute,
      ),
    );
  }
}
