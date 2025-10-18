import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/general/general_cubit.dart';
import '../../../../core/localization/localization_helper.dart';
import '../../../../shared/widgets/default_image_widget.dart';
import '../../domain/model/weather_model.dart';
import '../../domain/repository/endpoints.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CurrentWeatherCard({
    Key? key,
    required this.weather,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.theme.primaryColor.withOpacity(0.8),
            context.theme.primaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: context.theme.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // City name and favorite icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.cityName,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      weather.countryCode,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Weather icon and temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultImageWidget(
                WeatherEndpoints.getIconUrl(weather.icon, large: true),
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    generalCubit.formatTemperature(weather.temperature),
                    style: context.textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 72,
                    ),
                  ),
                  Text(
                    weather.weatherDescription.toUpperCase(),
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Weather details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem(
                  context,
                  generalCubit,
                  icon: Icons.thermostat_outlined,
                  label: LocalizationHelper.tr.feelsLike,
                  value: generalCubit.formatTemperature(weather.feelsLike),
                ),
                _buildDivider(),
                _buildDetailItem(
                  context,
                  generalCubit,
                  icon: Icons.water_drop_outlined,
                  label: LocalizationHelper.tr.humidity,
                  value: '${weather.humidity}%',
                ),
                _buildDivider(),
                _buildDetailItem(
                  context,
                  generalCubit,
                  icon: Icons.air,
                  label: LocalizationHelper.tr.wind,
                  value: '${weather.windSpeed.toStringAsFixed(1)} m/s',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    GeneralCubit generalCubit, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 50,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }
}
