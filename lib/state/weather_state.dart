import 'package:flutter/foundation.dart';

import '../api/weather_error.dart';
import '../models/weather_data.dart';
import '../repos/weather_repo.dart';

class WeatherState extends ChangeNotifier {
  final WeatherRepo repo;

  WeatherData? data;
  bool loading = false;
  String? error;
  bool notFound = false;
  bool _closed = false;

  WeatherState({required this.repo});

  Future<void> load(String city) async {
    if (loading || _closed) {
      return;
    }

    data = null;
    error = null;
    notFound = false;
    loading = true;
    notifyListeners();

    try {
      final result = await repo.getWeather(city);
      if (!_closed) {
        data = result;
      }
    } on WeatherError catch (e) {
      if (!_closed) {
        error = e.message;
        notFound = e.notFound;
      }
    } finally {
      loading = false;
      if (!_closed) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _closed = true;
    super.dispose();
  }
}
