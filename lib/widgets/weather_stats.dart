import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/weather.dart';
import '../theme.dart';
import 'soft_card.dart';

class WeatherStats extends StatelessWidget {
  final Weather weather;

  const WeatherStats({super.key, required this.weather});

  Widget stat(String title, String value, Widget icon) {
    return Row(
      children: [
        SizedBox(width: 36, height: 36, child: icon),
        const SizedBox(width: 16),
        Expanded(
          child: Text(title, style: const TextStyle(color: muted)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String pressure = 'Нет данных';
    if (weather.pressure != null) {
      pressure = '${(weather.pressure! * 0.75006).round()} мм рт. ст.';
    }
    return SoftCard(
      child: Column(
        children: [
          stat(
            'Влажность',
            '${weather.humidity}%',
            SvgPicture.asset('lib/icons/Indicators/Humidity.svg'),
          ),
          const Divider(height: 28, color: background),
          stat(
            'Ветер',
            '${weather.wind.toStringAsFixed(1)} м/с',
            SvgPicture.asset('lib/icons/Windy/Windy.svg'),
          ),
          const Divider(height: 28, color: background),
          stat(
            'Давление',
            pressure,
            const Icon(Icons.speed_rounded, color: blue, size: 30),
          ),
        ],
      ),
    );
  }
}
