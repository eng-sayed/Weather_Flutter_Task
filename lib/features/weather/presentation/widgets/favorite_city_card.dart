import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/localization_helper.dart';
import '../../domain/model/favorite_city_model.dart';

class FavoriteCityCard extends StatelessWidget {
  final FavoriteCityModel city;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const FavoriteCityCard({
    Key? key,
    required this.city,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(city.cityName + city.countryCode),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 32),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Location icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: context.theme.primaryColor,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 16),

                // City info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        city.cityName,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        city.countryCode,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.theme.textTheme.bodySmall?.color
                              ?.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${LocalizationHelper.tr.added} ${_formatDate(city.addedAt)}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.textTheme.bodySmall?.color
                              ?.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.theme.textTheme.bodySmall?.color?.withOpacity(
                    0.4,
                  ),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return LocalizationHelper.tr.today;
    } else if (difference.inDays == 1) {
      return LocalizationHelper.tr.yesterday;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${LocalizationHelper.tr.daysAgo}';
    } else {
      return DateFormat('MMM d, y').format(date);
    }
  }
}
