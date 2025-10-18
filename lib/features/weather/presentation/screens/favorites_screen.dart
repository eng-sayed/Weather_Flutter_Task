import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/utils/Locator.dart';
import 'package:task_flutter/core/Router/navigation_helper.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/localization_helper.dart';
import '../../cubit/weather_cubit.dart';
import '../../cubit/weather_states.dart';
import '../widgets/favorite_city_card.dart';
import '../widgets/weather_empty_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<WeatherCubit>(),
      child: BlocBuilder<WeatherCubit, WeatherStates>(
        builder: (context, state) {
          final cubit = WeatherCubit.get(context);

          return Scaffold(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                LocalizationHelper.tr.favoriteCities,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Text(
                      '${cubit.favorites.length}/5',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body:
                cubit.favorites.isEmpty
                    ? WeatherEmptyWidget(
                      title: LocalizationHelper.tr.noFavoritesYet,
                      description: LocalizationHelper.tr.noFavoritesDescription,
                      icon: Icons.favorite_border,
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: cubit.favorites.length,
                      itemBuilder: (context, index) {
                        final city = cubit.favorites[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: FavoriteCityCard(
                            city: city,
                            onTap: () {
                              cubit.selectFavoriteCity(city);
                              NavigationService.pop();
                            },
                            onDelete: () {
                              cubit.removeFromFavorites(city);
                            },
                          ),
                        );
                      },
                    ),
          );
        },
      ),
    );
  }
}
