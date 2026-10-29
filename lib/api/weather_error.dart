// Ошибка с понятным сообщением для будущего экрана.
class WeatherError implements Exception {
  final String message;
  final bool notFound;

  WeatherError(this.message, {this.notFound = false});

  @override
  String toString() => message;
}
