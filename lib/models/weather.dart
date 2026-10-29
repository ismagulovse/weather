class Weather {
  final String city;
  final double temp;
  final String text;
  final int code;
  final bool isDay;
  final int humidity;
  final double wind;
  final double? pressure;

  Weather({
    required this.city,
    required this.temp,
    required this.text,
    required this.code,
    this.isDay = true,
    required this.humidity,
    required this.wind,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final city = json['location'];
    final now = json['current'];
    final condition = now['condition'];

    return Weather(
      city: city['name'],
      temp: (now['temp_c'] as num).toDouble(),
      text: condition['text'],
      code: condition['code'],
      isDay: now['is_day'] != 0,
      humidity: now['humidity'],
      wind: (now['wind_kph'] as num).toDouble() / 3.6,
      pressure: (now['pressure_mb'] as num?)?.toDouble(),
    );
  }
}
