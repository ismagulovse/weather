import 'package:flutter/material.dart';

import '../models/day.dart';
import '../theme.dart';
import 'soft_card.dart';
import 'weather_icon.dart';

class ForecastCard extends StatelessWidget {
  final List<Day> days;

  const ForecastCard({super.key, required this.days});

  String dateLabel(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    const names = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return '${names[date.weekday - 1]}, ${date.day}.${date.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Прогноз по дням',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          const Text(
            'Максимум и минимум',
            style: TextStyle(color: muted, fontSize: 13),
          ),
          const SizedBox(height: 16),
          for (final day in days)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(child: Text(dateLabel(day.date))),
                  WeatherIcon(code: day.code, size: 42),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      '${day.maxTemp.round()}° / ${day.minTemp.round()}°',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
