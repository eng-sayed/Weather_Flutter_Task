import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/localization_helper.dart';

class WeatherErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const WeatherErrorWidget({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: context.theme.primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(LocalizationHelper.tr.retry),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
