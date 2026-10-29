import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api/weather_api.dart';
import 'repos/weather_repo.dart';
import 'screens/weather_screen.dart';
import 'state/weather_state.dart';
import 'state/favorite_state.dart';
import 'storage/favorite_store.dart';
import 'theme.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final client = http.Client();
  late final WeatherState state;
  final favorites = FavoriteState(store: FavoriteStore());

  @override
  void initState() {
    super.initState();
    final api = WeatherApi(client: client);
    final repo = WeatherRepo(api: api);
    state = WeatherState(repo: repo);
    favorites.load();
  }

  @override
  void dispose() {
    state.dispose();
    favorites.dispose();
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Погода',
      theme: appTheme,
      home: WeatherScreen(state: state, favorites: favorites),
    );
  }
}
