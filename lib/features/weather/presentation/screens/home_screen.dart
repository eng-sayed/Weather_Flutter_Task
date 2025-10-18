import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/Router/Router.dart';
import 'package:task_flutter/core/Router/navigation_helper.dart';
import 'package:task_flutter/core/utils/locator.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/localization_helper.dart';
import '../../../../shared/widgets/loadinganderror.dart';
import '../../cubit/weather_cubit.dart';
import '../../cubit/weather_states.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/favorite_city_card.dart';
import '../widgets/forecast_item.dart';
import '../widgets/weather_detail_row.dart';
import '../widgets/weather_empty_widget.dart';
import '../widgets/weather_popup_menu.dart';
import 'favorites_screen.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late WeatherCubit cubit = locator<WeatherCubit>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit
        ..init()
        ..getCurrentWeather('London');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: LoadingAndError(
              isError: state is CurrentWeatherErrorState,
              isLoading: state is CurrentWeatherLoadingState,
              function: () => cubit.getCurrentWeather('Egypt'),
              child: _buildBody(cubit),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(WeatherCubit cubit) {
    return cubit.currentWeather == null
        ? WeatherEmptyWidget(
          title: LocalizationHelper.tr.noWeatherData,
          description: LocalizationHelper.tr.noWeatherDataDescription,
          icon: Icons.cloud_off,
        )
        : RefreshIndicator(
          onRefresh: () async => await cubit.refreshWeather(),
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context, cubit),
              _buildSearchBar(context, cubit),
              _buildCurrentWeatherCard(context, cubit),
              _buildAdditionalDetails(context, cubit),
              if (cubit.forecast != null) ..._buildForecast(context, cubit),
              if (cubit.favorites.isNotEmpty)
                ..._buildFavorites(context, cubit),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        );
  }

  Widget _buildAppBar(BuildContext context, WeatherCubit cubit) {
    return SliverAppBar(
      floating: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        LocalizationHelper.tr.weatherForecast,
        style: context.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        // Weather PopupMenu with Theme, Favorites, and Language
        WeatherPopupMenu(favoritesCount: cubit.favorites.length),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, WeatherCubit cubit) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: InkWell(
          onTap: () {
            NavigationService.pushNamed(Routes.weatherSearch);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.theme.dividerColor.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: context.theme.textTheme.bodySmall?.color?.withOpacity(
                    0.5,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  LocalizationHelper.tr.searchCityHint,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.theme.textTheme.bodySmall?.color
                        ?.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherCard(BuildContext context, WeatherCubit cubit) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: CurrentWeatherCard(
          weather: cubit.currentWeather!,
          isFavorite: cubit.isFavorite(cubit.currentWeather!.cityName),
          onFavoriteToggle: () {
            if (cubit.isFavorite(cubit.currentWeather!.cityName)) {
              final city = cubit.favorites.firstWhere(
                (c) => c.cityName == cubit.currentWeather!.cityName,
              );
              cubit.removeFromFavorites(city);
            } else {
              cubit.addToFavorites(cubit.currentWeather!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildAdditionalDetails(BuildContext context, WeatherCubit cubit) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalizationHelper.tr.additionalDetails,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            WeatherDetailRow(
              icon: Icons.compress,
              label: LocalizationHelper.tr.pressure,
              value: '${cubit.currentWeather!.pressure} hPa',
            ),
            const SizedBox(height: 8),
            if (cubit.currentWeather!.visibility != null)
              WeatherDetailRow(
                icon: Icons.visibility,
                label: LocalizationHelper.tr.visibility,
                value:
                    '${(cubit.currentWeather!.visibility! / 1000).toStringAsFixed(1)} km',
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildForecast(BuildContext context, WeatherCubit cubit) {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            LocalizationHelper.tr.forecast,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: cubit.forecast!.getDailyForecasts().length,
            itemBuilder: (context, index) {
              final dailyForecast = cubit.forecast!.getDailyForecasts()[index];
              return ForecastItem(dailyForecast: dailyForecast);
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildFavorites(BuildContext context, WeatherCubit cubit) {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalizationHelper.tr.favoriteCities,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => BlocProvider.value(
                            value: cubit,
                            child: const FavoritesScreen(),
                          ),
                    ),
                  );
                },
                child: Text(LocalizationHelper.tr.seeAll),
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final city = cubit.favorites[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FavoriteCityCard(
                  city: city,
                  onTap: () {
                    cubit.selectFavoriteCity(city);
                  },
                  onDelete: () {
                    cubit.removeFromFavorites(city);
                  },
                ),
              );
            },
            childCount: cubit.favorites.length > 3 ? 3 : cubit.favorites.length,
          ),
        ),
      ),
    ];
  }
}
