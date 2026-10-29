import 'package:flutter/material.dart';

import '../state/weather_state.dart';
import '../state/favorite_state.dart';
import '../widgets/favorites.dart';
import '../theme.dart';
import '../widgets/weather_body.dart';

class WeatherScreen extends StatefulWidget {
  final WeatherState state;
  final FavoriteState favorites;

  const WeatherScreen({
    super.key,
    required this.state,
    required this.favorites,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final city = TextEditingController();
  String lastCity = '';

  void search() {
    FocusScope.of(context).unfocus();
    lastCity = city.text.trim();
    widget.state.load(lastCity);
  }

  @override
  void dispose() {
    city.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.state,
          builder: (context, child) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Погода',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const SizedBox(height: 28),
                    TextField(
                      controller: city,
                      enabled: !widget.state.loading,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => search(),
                      decoration: InputDecoration(
                        hintText: 'Название города',
                        suffixIcon: IconButton(
                          tooltip: 'Найти погоду',
                          onPressed: widget.state.loading ? null : search,
                          icon: const Icon(Icons.search, color: blue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Favorites(
                      state: widget.favorites,
                      city: widget.state.data?.weather.city,
                      loading: widget.state.loading,
                      onSelect: (name) {
                        city.text = name;
                        search();
                      },
                    ),
                    const SizedBox(height: 24),
                    WeatherBody(
                      state: widget.state,
                      retry: () => widget.state.load(lastCity),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
