import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/state/favorite_state.dart';
import 'package:weather/storage/favorite_store.dart';
import 'package:weather/widgets/favorites.dart';

// Подменяем только хранилище, чтобы тесты не меняли настоящие города.
class TestStore extends FavoriteStore {
  List<String> saved = [];
  bool fail = false;

  @override
  Future<List<String>> load() async {
    if (fail) throw Exception('storage unavailable');
    return List<String>.of(saved);
  }

  @override
  Future<void> save(List<String> cities) async {
    if (fail) throw Exception('storage unavailable');
    saved = List<String>.of(cities);
  }
}

void main() {
  test('Добавление, восстановление новым состоянием и удаление', () async {
    final store = TestStore();
    final first = FavoriteState(store: store);
    final second = FavoriteState(store: store);
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    await first.load();
    await first.toggle(' Москва ');
    expect(first.cities, ['Москва']);
    expect(first.has('МОСКВА'), true);
    await second.load();
    expect(second.cities, ['Москва']);
    await second.toggle('москва');
    expect(second.cities, isEmpty);
    expect(store.saved, isEmpty);
  });

  test('Ошибка записи сохраняет прежний список', () async {
    final store = TestStore();
    final state = FavoriteState(store: store);
    addTearDown(state.dispose);
    await state.load();
    await state.toggle('Москва');
    store.fail = true;
    await state.toggle('Казань');
    expect(state.cities, ['Москва']);
    expect(state.error, isNotNull);
    expect(state.busy, false);
    store.fail = false;
    await state.toggle('Казань');
    expect(state.cities, ['Москва', 'Казань']);
    expect(state.error, isNull);
  });

  test('До чтения списка запись запрещена, чтение можно повторить', () async {
    final store = TestStore();
    store.saved = ['Москва'];
    store.fail = true;
    final state = FavoriteState(store: store);
    addTearDown(state.dispose);
    await state.load();
    await state.toggle('Казань');
    expect(state.ready, false);
    expect(store.saved, ['Москва']);
    store.fail = false;
    await state.load();
    expect(state.ready, true);
    expect(state.cities, ['Москва']);
  });

  testWidgets('Кнопка сохраняет город, нажатие выбирает, крестик удаляет', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final state = FavoriteState(store: TestStore());
    addTearDown(state.dispose);
    await state.load();
    String selected = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Favorites(
              state: state,
              city: 'Екатеринбург',
              loading: false,
              onSelect: (city) {
                selected = city;
              },
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Добавить в избранное'));
    await tester.pumpAndSettle();
    expect(state.cities, ['Екатеринбург']);
    expect(find.text('Убрать из избранного'), findsOneWidget);
    await tester.tap(find.text('Екатеринбург'));
    expect(selected, 'Екатеринбург');
    await tester.tap(find.byTooltip('Убрать из избранного'));
    await tester.pumpAndSettle();
    expect(state.cities, isEmpty);
    expect(tester.takeException(), isNull);
  });
}
