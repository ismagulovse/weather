import '../api/weather_api.dart';
import '../api/weather_error.dart';
import '../models/day.dart';
import '../models/weather.dart';
import '../models/weather_data.dart';

class WeatherRepo {
  final WeatherApi api;

  WeatherRepo({required this.api});

  Future<WeatherData> getWeather(String city) async {
   
    final json = await api.getWeather(city);

    try {
      final weather = Weather.fromJson(json);
      final forecast = json['forecast'];
      if (forecast is! Map || forecast['forecastday'] is! List) {
        throw FormatException('Нет списка прогноза');
      }
      final list = forecast['forecastday'];
      final days = <Day>[];

      for (final item in list) {
        if (item is! Map<String, dynamic>) {
          throw FormatException('Неверный день прогноза');
        }
        days.add(Day.fromJson(item));
      }

      if (days.isEmpty) {
        throw WeatherError('Сервис не вернул прогноз');
      }

      return WeatherData(weather: weather, days: days);
    } on FormatException {
      throw WeatherError('Не удалось прочитать данные');
    }
  }
}
