import 'package:flutter/material.dart';

import '../state/favorite_state.dart';
import '../theme.dart';

class Favorites extends StatelessWidget {
  final FavoriteState state;
  final String? city;
  final bool loading;
  final ValueChanged<String> onSelect;

  const Favorites({
    super.key,
    required this.state,
    required this.city,
    required this.loading,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Избранное',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            if (state.busy)
              const Text(
                'Сохраняем или загружаем города…',
                style: TextStyle(color: muted),
              ),
            if (state.ready && state.cities.isEmpty)
              const Text(
                'Найди город и добавь его в избранное.',
                style: TextStyle(color: muted),
              ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final name in state.cities)
                  InputChip(
                    label: Text(name),
                    onPressed: loading || state.busy
                        ? null
                        : () => onSelect(name),
                    onDeleted: state.busy ? null : () => state.toggle(name),
                    deleteButtonTooltipMessage: 'Убрать из избранного',
                  ),
              ],
            ),
            if (city != null && !loading) ...[
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: !state.ready || state.busy
                    ? null
                    : () => state.toggle(city!),
                child: Text(
                  state.has(city!)
                      ? 'Убрать из избранного'
                      : 'Добавить в избранное',
                ),
              ),
            ],
            if (state.error != null) ...[
              const SizedBox(height: 8),
              Text(
                state.error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              if (!state.ready)
                TextButton(
                  onPressed: state.busy ? null : state.load,
                  child: const Text('Повторить'),
                ),
            ],
          ],
        );
      },
    );
  }
}
