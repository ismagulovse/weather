import 'package:flutter/material.dart';

import '../state/weather_state.dart';
import 'forecast_card.dart';
import 'now_card.dart';
import 'state_card.dart';
import 'weather_stats.dart';


class WeatherBody extends StatelessWidget {
  final WeatherState state;
  final VoidCallback retry;
  const WeatherBody({super.key, required this.state, required this.retry});

  @override
  Widget build(BuildContext context) {
    if (state.loading) {
      return const Padding(
        padding: EdgeInsets.all(48),
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Загрузка'),
          ],
        ),
      );
    }
    if (state.error != null) {
      return StateCard(
        title: state.notFound
            ? 'Город не найден'
            : 'Не удалось загрузить погоду',
        text: state.notFound ? 'Неверное название города' : state.error!,
        icon: null,
        retry: retry,
      );
    }
    final data = state.data;
    if (data == null) {
      return const StateCard(
        title: 'Найди город',
        text: 'Введи название города',
        icon: null,
      );
    }
    return Column(
      children: [
        NowCard(weather: data.weather),
        const SizedBox(height: 24),
        WeatherStats(weather: data.weather),
        const SizedBox(height: 24),
        ForecastCard(days: data.days),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: retry,
          icon: const Icon(Icons.refresh),
          label: const Text('Обновить погоду'),
        ),
      ],
    );
  }
}
