import 'package:flutter/material.dart';

import '../models/weather.dart';
import '../theme.dart';
import 'soft_card.dart';
import 'weather_icon.dart';

class NowCard extends StatelessWidget {
  final Weather weather;

  const NowCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Column(
        children: [
          const Text(
            'Сейчас',
            style: TextStyle(color: muted, fontSize: 12, letterSpacing: 2),
          ),
          const SizedBox(height: 10),
          Text(
            weather.city,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            children: [
              WeatherIcon(code: weather.code, isDay: weather.isDay, size: 112),
              Text(
                '${weather.temp.round()}°',
                style: const TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            weather.text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: muted, fontSize: 17),
          ),
          const SizedBox(height: 8),
          const Text(
            'Температура',
            style: TextStyle(color: muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
