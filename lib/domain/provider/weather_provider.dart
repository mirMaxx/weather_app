import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app1/domain/hive/favorite_model.dart';
import 'package:weather_app1/domain/hive/hive_box.dart';
import 'package:weather_app1/domain/weather_api/weather_api.dart';
import 'package:weather_app1/domain/weather_json/coords.dart';
import 'package:weather_app1/domain/weather_json/weather_data.dart';
import 'package:weather_app1/resourses/bg.dart';
import 'package:weather_app1/ui/theme/app_colors.dart';

class WeatherProvider extends ChangeNotifier {
  Coords? _coords;
  Coords? get coords => _coords;

  WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;

  Current? _current;
  Current? get current => _current;

  Future<WeatherData?> setUp({String? cityName}) async {
    final pref = await SharedPreferences.getInstance();
    cityName = pref.getString('City');
    _coords = await WeatherApi.getCoords(cityName ?? 'Tashkent');
    _weatherData = await WeatherApi.getWeather(coords!);
    _current = _weatherData?.current;
    return _weatherData;
  }

  TextEditingController cityController = TextEditingController();

  Future<void> searchCity(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    final city = cityController.text;
    pref.setString('City', city);
    await setUp(cityName: city).then((value) => Navigator.of(context).pop());
    cityController.clear();
    notifyListeners();
  }

  // Kelvin value
  final _kelvin = -273.15;
  // Current city name
  String? _currentCity;
  String? get currentCity => _currentCity;

  String setCurrentCity() {
    try {
      _currentCity = _weatherData?.timezone;
      return _currentCity ?? 'Error';
    } catch (e) {
      _currentCity = 'Нет интернета';
    }
    return 'Error';
  }

  int? _currentTemp;
  int? get currentTemp => _currentTemp;

  int setCurrentTemp() {
    try {
      _currentTemp = ((_current?.temp ?? -_kelvin) + _kelvin).round();
      return _currentTemp ?? -500;
    } catch (e) {
      _currentTemp = -500;
    }
    return -500;
  }

  final List _values = [];
  List get values => _values;

  double setValues(int index) {
    _values.add((_current?.windSpeed ?? 0) / 1);
    _values.add(((_current?.feelsLike ?? -_kelvin) + _kelvin).roundToDouble());
    _values.add((_current?.humidity ?? 0.0) / 1);
    _values.add((_current?.visibility ?? 0.0) / 1000);
    return _values[index];
  }

  String _currentSunset = '';
  String get currentSunset => _currentSunset;

  String setCurrentSunset() {
    final getCurrentSunset =
        (_current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);

    final setCurrentSunsetTime =
        DateTime.fromMillisecondsSinceEpoch(getCurrentSunset * 1000);

    _currentSunset = DateFormat('HH:mm').format(setCurrentSunsetTime);

    return _currentSunset;
  }

  String _currentSunRise = '';
  String get currentSunRise => _currentSunRise;

  String setCurrentSunRice() {
    final getCurrentSunRise =
        (_current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);

    final setCurrentSunRiseTime =
        DateTime.fromMillisecondsSinceEpoch(getCurrentSunRise * 1000);

    _currentSunRise = DateFormat('HH:mm').format(setCurrentSunRiseTime);

    return _currentSunRise;
  }

  int _dailyDayTemp = 0;
  int get dailyDayTemp => _dailyDayTemp;

  int setdailyDayTemp(int index) {
    _dailyDayTemp =
        ((weatherData?.daily?[index].temp?.day ?? -_kelvin) + _kelvin).round();

    return _dailyDayTemp;
  }

  int _dailyNightTemp = 0;
  int get dailyNightTemp => _dailyNightTemp;

  int setdailyNightTemp(int index) {
    _dailyNightTemp =
        ((weatherData?.daily?[index].temp?.night ?? -_kelvin) + _kelvin)
            .round();

    return _dailyNightTemp;
  }

  final List _dailyDays = [];
  List get dailyDays => _dailyDays;

  String setDailyDay(int index) {
    try {
      for (var i = 0; i < weatherData!.daily!.length; i++) {
        if (i == 0 && _dailyDays.isNotEmpty) _dailyDays.clear();

        if (i == 0) {
          _dailyDays.add('Сегодня');
        } else {
          final getDay = (weatherData!.daily![i].dt!) * 1000;
          final dayItem = DateTime.fromMillisecondsSinceEpoch(getDay);

          _dailyDays.add(DateFormat('EEEE', 'ru').format(dayItem));
        }
      }
      return _capitalize(_dailyDays[index]);
    } catch (e) {
      e;
    }
    return '';
  }

  String? _currentDay;
  String? get currentDay => _currentDay;

  String setCurrentDay() {
    final day = (weatherData!.current!.dt!) * 1000;
    final dateItem = DateTime.fromMillisecondsSinceEpoch(day);
    _currentDay = DateFormat('EEEE', 'ru').format(dateItem);
    return _capitalize(_currentDay ?? 'Error');
  }

  String? _currentWeatherStatus;
  String? get currentWeatherStatus => _currentWeatherStatus;

  String setCurrentWeatherStatus() {
    _currentWeatherStatus = weatherData?.current?.weather?[0].description;
    return _capitalize(_currentWeatherStatus ?? 'Error');
  }

  final String _iconUrlPath = 'http://openweathermap.org/img/wn/';

  String setCurrentIcon() {
    final getCurrentIcon = weatherData?.current?.weather?[0].icon;

    final setIcon = '$_iconUrlPath${getCurrentIcon!}.png';

    return setIcon;
  }

  String setDailyIcons(int index) {
    final getDailyIcon = weatherData?.daily?[index].weather?[0].icon;
    final setIcon = '$_iconUrlPath${getDailyIcon!}.png';
    return setIcon;
  }

  String _getWeatherBg = Bg.clearBg;
  String get getWeatherBg => _getWeatherBg;

  String setWeatherTheme() {
    //int id = _current?.weather?[0].id ?? -1;
    int id = 701;

    if (id == -1 || _current?.sunset == null || _current?.dt == null) {
      return Bg.clearBg;
    }

    try {
      if (_current!.sunset! > _current!.dt!) {
        if (id >= 200 && id <= 531) {
          _getWeatherBg = Bg.rainBg;
          AppColors.primaryColor = const Color(0xFF030708);
          AppColors.secondaryColor = const Color(0xFF002C25);
          AppColors.blockBgColor = const Color.fromRGBO(106, 141, 135, 0.5);
        } else if (id >= 600 && id <= 622) {
          _getWeatherBg = Bg.snowBg;
          AppColors.primaryColor = const Color(0xFF030708);
          AppColors.secondaryColor = const Color(0xFF002C25);
          AppColors.blockBgColor = const Color.fromRGBO(109, 160, 192, 0.5);
        } else if (id >= 701 && id <= 781) {
          _getWeatherBg = Bg.fogBg;
          AppColors.primaryColor = const Color(0xFF323232);
          AppColors.secondaryColor = const Color(0xFFFFFFFF);
          AppColors.blockBgColor = const Color.fromRGBO(142, 141, 141, 0.5);
        } else if (id >= 801 && id <= 804) {
          _getWeatherBg = Bg.cloudyBg;
          AppColors.primaryColor = const Color(0xFF001C39);
          AppColors.secondaryColor = const Color(0xFFFFFFFF);
          AppColors.blockBgColor = const Color.fromRGBO(140, 155, 170, 0.5);
        } else {
          _getWeatherBg = Bg.clearBg;
          AppColors.primaryColor = const Color(0xFF002535);
          AppColors.secondaryColor = const Color(0xFFFFFFFF);
          AppColors.blockBgColor = const Color.fromRGBO(80, 130, 155, 0.3);
        }
      } else {
        if (id >= 200 && id <= 531) {
          _getWeatherBg = Bg.rainNightBg;
          AppColors.primaryColor = const Color(0xFFC6C6C6);
          AppColors.secondaryColor = const Color(0xFFFFFFFF);
          AppColors.blockBgColor = const Color.fromRGBO(35, 35, 35, 0.5);
        } else if (id >= 600 && id <= 622) {
          _getWeatherBg = Bg.snowNightBg;
          AppColors.primaryColor = const Color(0xFFE6E6E6);
          AppColors.secondaryColor = const Color(0xFFF9DADA);
          AppColors.blockBgColor = const Color.fromRGBO(12, 23, 27, 0.5);
        } else if (id >= 701 && id <= 781) {
          _getWeatherBg = Bg.fogNightBg;
          AppColors.primaryColor = const Color(0xFFFFFFFF);
          AppColors.secondaryColor = const Color(0xFF999999);
          AppColors.blockBgColor = const Color.fromRGBO(35, 35, 35, 0.5);
        } else if (id >= 801 && id <= 804) {
          _getWeatherBg = Bg.cloudyNightBg;
          AppColors.primaryColor = const Color(0xFFE2E2E2);
          AppColors.secondaryColor = const Color(0xFF7E8386);
          AppColors.blockBgColor = const Color.fromRGBO(12, 23, 27, 0.5);
        } else {
          _getWeatherBg = Bg.clearNightBg;
          AppColors.primaryColor = const Color(0xFFFFFFFF);
          AppColors.secondaryColor = const Color(0xFF51DAFF);
          AppColors.blockBgColor = const Color.fromRGBO(47, 97, 148, 0.5);
        }
      }
    } catch (e) {
      return Bg.clearBg;
    }

    return _getWeatherBg;
  }

  Future<void> addFavorite() async {
    await HiveBox.favoriteBox.add(
      FavoriteModel(
        bg: _getWeatherBg,
        city: weatherData?.timezone ?? 'Error',
        color: AppColors.primaryColor.value,
      ),
    );
  }

  Future<void> removeFavorite(int index) async {
    await HiveBox.favoriteBox.deleteAt(index);
  }

  String _capitalize(String str) => str[0].toUpperCase() + str.substring(1);
}
