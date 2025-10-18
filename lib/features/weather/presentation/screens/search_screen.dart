import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/utils/locator.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/localization_helper.dart';
import '../../../../shared/widgets/loadinganderror.dart';
import '../../cubit/weather_cubit.dart';
import '../../cubit/weather_states.dart';
import '../../domain/model/weather_model.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/weather_empty_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<WeatherCubit>(),
      child: BlocConsumer<WeatherCubit, WeatherStates>(
        listener: (context, state) {
          // Handle navigation after successful search
        },
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
                LocalizationHelper.tr.searchCity,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                // Search Input
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: LocalizationHelper.tr.searchCityPlaceholder,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          _searchController.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  cubit.clearSearch();
                                  setState(() {});
                                },
                              )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: context.theme.cardColor,
                    ),
                    onChanged: (value) {
                      setState(() {});
                      if (value.trim().isNotEmpty) {
                        cubit.searchCity(value);
                      } else {
                        cubit.clearSearch();
                      }
                    },
                  ),
                ),

                // Search Results
                Expanded(child: _buildSearchResults(context, cubit, state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    WeatherCubit cubit,
    WeatherStates state,
  ) {
    if (_searchController.text.trim().isEmpty) {
      return WeatherEmptyWidget(
        title: LocalizationHelper.tr.searchForCity,
        description: LocalizationHelper.tr.searchForCityDescription,
        icon: Icons.search,
      );
    }

    final bool isLoading = state is SearchLoadingState;
    final bool isError = state is SearchErrorState;

    return LoadingAndError(
      isError: isError,
      isLoading: isLoading,
      function: () {
        if (_searchController.text.trim().isNotEmpty) {
          cubit.searchCity(_searchController.text);
        }
      },
      child:
          cubit.searchResults.isEmpty
              ? WeatherEmptyWidget(
                title: LocalizationHelper.tr.noResultsFound,
                description: LocalizationHelper.tr.noResultsFoundDescription,
                icon: Icons.cloud_off,
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: cubit.searchResults.length,
                itemBuilder: (context, index) {
                  final weather = cubit.searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildSearchResultCard(context, cubit, weather),
                  );
                },
              ),
    );
  }

  Widget _buildSearchResultCard(
    BuildContext context,
    WeatherCubit cubit,
    WeatherModel weather,
  ) {
    return InkWell(
      onTap: () {
        // Select this city and go back
        cubit.getCurrentWeather(weather.cityName);
        Navigator.pop(context);
      },
      child: CurrentWeatherCard(
        weather: weather,
        isFavorite: cubit.isFavorite(weather.cityName),
        onFavoriteToggle: () {
          if (cubit.isFavorite(weather.cityName)) {
            final city = cubit.favorites.firstWhere(
              (c) => c.cityName == weather.cityName,
            );
            cubit.removeFromFavorites(city);
          } else {
            cubit.addToFavorites(weather);
          }
        },
      ),
    );
  }
}
