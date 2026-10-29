import 'package:flutter/foundation.dart';

import '../storage/favorite_store.dart';

class FavoriteState extends ChangeNotifier {
  final FavoriteStore store;
  List<String> cities = [];
  bool busy = false;
  bool ready = false;
  String? error;
  bool _closed = false;

  FavoriteState({required this.store});

  bool has(String city) {
    for (final name in cities) {
      if (name.toLowerCase() == city.trim().toLowerCase()) return true;
    }
    return false;
  }

  Future<void> load() async {
    if (busy || _closed) return;
    busy = true;
    error = null;
    notifyListeners();
    try {
      cities = await store.load();
      ready = true;
    } catch (_) {
      error = 'Не удалось прочитать избранное.';
    } finally {
      busy = false;
      if (!_closed) notifyListeners();
    }
  }

  // Повторное нажатие удаляет уже сохранённый город.
  Future<void> toggle(String city) async {
    city = city.trim();
    if (!ready || busy || _closed || city.isEmpty) return;
    final next = List<String>.of(cities);
    if (has(city)) {
      next.removeWhere((name) => name.toLowerCase() == city.toLowerCase());
    } else {
      next.add(city);
    }
    busy = true;
    error = null;
    notifyListeners();
    try {
      await store.save(next);
      cities = next;
    } catch (_) {
      error = 'Не удалось сохранить избранное. Попробуй ещё раз.';
    } finally {
      busy = false;
      if (!_closed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _closed = true;
    super.dispose();
  }
}
