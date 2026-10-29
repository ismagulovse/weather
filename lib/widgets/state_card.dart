import 'package:flutter/material.dart';

import '../theme.dart';
import 'soft_card.dart';

class StateCard extends StatelessWidget {
  final String title;
  final String text;
  final IconData? icon;
  final VoidCallback? retry;

  const StateCard({
    super.key,
    required this.title,
    required this.text,
    this.icon = Icons.travel_explore_rounded,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Column(
        children: [
          const SizedBox(height: 24),
          if (icon != null) ...[
            Icon(icon, color: blue, size: 64),
            const SizedBox(height: 24),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: muted, height: 1.5),
          ),
          if (retry != null) ...[
            const SizedBox(height: 24),
            FilledButton(onPressed: retry, child: const Text('Повторить')),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
