@TestOn('browser')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/storage/favorite_store.dart';

void main() {
  test('Настоящее браузерное хранилище читает и сохраняет города', () async {
    final store = FavoriteStore();
    final before = await store.load();
    try {
      await store.save(['Москва', 'Казань']);
      expect(await FavoriteStore().load(), ['Москва', 'Казань']);
    } finally {
      await store.save(before);
    }
  });
}
