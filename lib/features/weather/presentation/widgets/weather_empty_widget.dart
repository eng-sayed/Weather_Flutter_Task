import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';

class WeatherEmptyWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const WeatherEmptyWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
            color: context.theme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
