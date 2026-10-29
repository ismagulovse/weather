import 'package:flutter/material.dart';

class SoftCard extends StatelessWidget {
  final Widget child;

  const SoftCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFDFE),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD0DCE7),
            blurRadius: 18,
            offset: Offset(7, 7),
          ),
          BoxShadow(
            color: Color(0xFFF7FBFF),
            blurRadius: 18,
            offset: Offset(-7, -7),
          ),
        ],
      ),
      child: child,
    );
  }
}
