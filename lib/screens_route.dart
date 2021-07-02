import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:weather/screens/next_week.dart';

const String initialRoute = HomeScreen.routeName;

class ScreensRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home_page':
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case '/home_page/next_week':
        return MaterialPageRoute(builder: (_) => NextWeekScreen());
    }
  }
}
