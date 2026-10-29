import 'package:shared_preferences/shared_preferences.dart';

// Сохраняем только названия городов. Погоду загружаем заново.
class FavoriteStore {
  Future<List<String>> load() async {
    final prefs = SharedPreferencesAsync();
    return await prefs.getStringList('cities') ?? [];
  }

  Future<void> save(List<String> cities) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setStringList('cities', cities);
  }
}
