import 'package:flutter/cupertino.dart';
import 'package:weather_app1/ui/app_navigator/app_routes.dart';
import 'package:weather_app1/ui/pages/home_page/home_page.dart';
import 'package:weather_app1/ui/pages/search_page/search_page.dart';

class AppNavigator {
  static String get initialRoute => AppRoutes.homePage;

  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.homePage: (context) => const HomePage(),
        AppRoutes.search: (context) => const SearchPage(),
      };
}
