import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/general/general_cubit.dart';
import '../../../../shared/widgets/default_image_widget.dart';
import '../../domain/model/forecast_model.dart';
import '../../domain/repository/endpoints.dart';

class ForecastItem extends StatelessWidget {
  final DailyForecast dailyForecast;

  const ForecastItem({Key? key, required this.dailyForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        final generalCubit = GeneralCubit.get(context);
        return _buildCard(context, generalCubit);
      },
    );
  }

  Widget _buildCard(BuildContext context, GeneralCubit generalCubit) {
    final firstForecast = dailyForecast.forecasts.first;
    final date = firstForecast.dateTime;
    final dayName = DateFormat('EEE').format(date);
    final dateStr = DateFormat('MMM d').format(date);

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Day name
          Text(
            dayName,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          // Date
          Text(
            dateStr,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),

          const SizedBox(height: 12),

          // Weather icon
          DefaultImageWidget(
            WeatherEndpoints.getIconUrl(dailyForecast.getMostCommonIcon()),
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 12),

          // Temperature range
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                generalCubit.formatTemperature(dailyForecast.getMaxTemp()),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ' / ',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.theme.textTheme.bodySmall?.color?.withOpacity(
                    0.6,
                  ),
                ),
              ),
              Text(
                generalCubit.formatTemperature(dailyForecast.getMinTemp()),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.textTheme.bodySmall?.color?.withOpacity(
                    0.6,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Weather description
          Text(
            dailyForecast.getMostCommonDescription(),
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
