import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';

class WeatherDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetailRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.dividerColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: context.theme.primaryColor, size: 24),
          ),

          const SizedBox(width: 16),

          // Label
          Expanded(child: Text(label, style: context.textTheme.bodyLarge)),

          // Value
          Text(
            value,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
