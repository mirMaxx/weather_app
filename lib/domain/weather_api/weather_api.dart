import 'dart:convert';
import 'dart:io';
import 'package:weather_app1/domain/weather_json/coords.dart';
import 'package:weather_app1/domain/weather_json/weather_data.dart';

class WeatherApi {
  static const String _host = 'api.openweathermap.org';
  static const String _apiKey = '49cc8c821cd2aff9af04c9f98c36eb74';

  static Future<Coords?> getCoords(String cityName) async {
    Uri url = Uri(
      scheme: 'https',
      host: _host,
      path: 'data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': _apiKey,
        'lang': 'ru',
      },
    );

    try {
      final data = await _jsonRequest(url);
      final coords = Coords.fromjson(data);
      return coords;
    } catch (e) {
      Uri url = Uri(
        scheme: 'https',
      host: _host,
      path: 'data/2.5/weather',
      queryParameters: {
        'q': 'Tashkent',
        'appid': _apiKey,
        'lang': 'ru',
      },
      );
      final data = await _jsonRequest(url);
      final coords = Coords.fromjson(data);
      return coords;
    }
  }

  static Future<WeatherData?> getWeather(Coords coords) async {
    Uri url = Uri(
      scheme: 'https',
      host: _host,
      path: 'data/2.5/onecall',
      queryParameters: {
        'lat': coords.lat.toString(),
        'lon': coords.lon.toString(),
        'exclude': 'hourly,minutely',
        'appid': _apiKey,
        'lang': 'ru',
      },
    );
    try {
      final data = await _jsonRequest(url);
      final weatherData = WeatherData.fromJson(data);
      return weatherData;
    } catch (e) {
      e;
    }
    return null;
  }

  static Future<Map<String, dynamic>> _jsonRequest(Uri url) async {
    try {
      // Клиент через которого мы делаем запрос
      final client = HttpClient();
      // Запрос
      final request = await client.getUrl(url);
      // Ответ
      final response = await request.close();

      final json = await response.transform(utf8.decoder).toList();

      final jsonString = json.join();

      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      return data;
    } catch (e) {
      return {};
    }
  }
}
