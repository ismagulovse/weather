class Day {
  final String date;
  final double minTemp;
  final double maxTemp;
  final int code;

  Day({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.code,
  });

  // Принимает один элемент списка forecastday.
  static Day fromJson(Map<String, dynamic> json) {
    final day = json['day'];
    if (day is! Map) {
      throw FormatException('Нет данных');
    }

    final condition = day['condition'];
    if (condition is! Map) {
      throw FormatException('Нет описания');
    }

    if (json['date'] is! String ||
        day['mintemp_c'] is! num ||
        day['maxtemp_c'] is! num ||
        condition['code'] is! int) {
      throw FormatException('Неверные данные');
    }

    return Day(
      date: json['date'],
      minTemp: day['mintemp_c'].toDouble(),
      maxTemp: day['maxtemp_c'].toDouble(),
      code: condition['code'],
    );
  }
}
