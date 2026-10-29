import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'weather_error.dart';

class WeatherApi {
  final http.Client client;
  final String key;

  WeatherApi({
    required this.client,
    this.key = '5a6812497854437f8f971253262510',
  });

  Future<Map<String, dynamic>> getWeather(String city) async {
    city = city.trim();
    if (city.isEmpty) {
      throw WeatherError('Введите название города.');
    }
    if (key.isEmpty) {
      throw WeatherError('Не задан ключ WeatherAPI.');
    }

    final url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': key,
      'q': city,
      'days': '5',
      'lang': 'ru',
    });

    try {
      final response = await client
          .get(url)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode >= 500) {
        throw WeatherError('Сервис погоды недоступен');
      }
      if (response.statusCode == 404) {
        throw WeatherError('API не найден.');
      }
      if (response.statusCode == 401 || response.statusCode == 403) {
        throw WeatherError('Проблема API или лимита запросов');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data is! Map<String, dynamic>) {
        throw WeatherError('Неверный формат');
      }

      if (response.statusCode != 200) {
        final error = data['error'];
        if (error is Map && error['code'] == 1006) {
          throw WeatherError('Город не найден.', notFound: true);
        }
        throw WeatherError('Ошибка запроса: ${response.statusCode}.');
      }

      return data;
    } on TimeoutException {
      throw WeatherError('Сервис не отвечает');
    } on http.ClientException {
      throw WeatherError('Нет подключения');
    } on FormatException {
      throw WeatherError('Неверный формат данных.');
    }
  }
}
