import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Router/Router.dart';
import '../../../../core/Router/navigation_helper.dart';
import '../../../../core/general/general_cubit.dart';
import '../../../../core/localization/localization_helper.dart';
import '../../../../core/style/app_theme.dart';

class WeatherPopupMenu extends StatelessWidget {
  final int favoritesCount;

  const WeatherPopupMenu({Key? key, this.favoritesCount = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralCubit, GeneralState>(
      builder: (context, state) {
        final generalCubit = GeneralCubit.get(context);

        return PopupMenuButton<_MenuAction>(
          icon: Icon(Icons.more_vert, color: AppColors.primary),
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemBuilder:
              (context) => [
                PopupMenuItem<_MenuAction>(
                  value: _MenuAction.theme,
                  child: _buildMenuItem(
                    icon:
                        generalCubit.isLightMode
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                    title:
                        generalCubit.isLightMode
                            ? LocalizationHelper.tr.darkMode
                            : LocalizationHelper.tr.lightMode,
                    subtitle: LocalizationHelper.tr.changeAppearance,
                    iconColor:
                        generalCubit.isLightMode ? Colors.indigo : Colors.amber,
                  ),
                ),

                const PopupMenuDivider(),
                PopupMenuItem<_MenuAction>(
                  value: _MenuAction.favorites,
                  child: _buildMenuItem(
                    icon: Icons.favorite,
                    title: LocalizationHelper.tr.favoriteCities,
                    subtitle:
                        favoritesCount > 0
                            ? '$favoritesCount ${LocalizationHelper.tr.cities}'
                            : LocalizationHelper.tr.noFavorites,
                    iconColor: Colors.red,
                    badge: favoritesCount > 0 ? favoritesCount : null,
                  ),
                ),

                const PopupMenuDivider(),
                PopupMenuItem<_MenuAction>(
                  value: _MenuAction.temperatureUnit,
                  child: _buildMenuItem(
                    icon: Icons.thermostat,
                    title: LocalizationHelper.tr.temperatureUnit,
                    subtitle:
                        generalCubit.isCelsius
                            ? LocalizationHelper.tr.celsius
                            : LocalizationHelper.tr.fahrenheit,
                    iconColor: Colors.orange,
                  ),
                ),

                const PopupMenuDivider(),
                PopupMenuItem<_MenuAction>(
                  value: _MenuAction.language,
                  child: _buildMenuItem(
                    icon: Icons.language,
                    title: LocalizationHelper.tr.language,
                    subtitle: LocalizationHelper.currentLocalName,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
          onSelected: (action) => _handleMenuAction(context, action),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    int? badge,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Icon(icon, color: iconColor, size: 24),
              if (badge != null)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleMenuAction(BuildContext context, _MenuAction action) {
    final generalCubit = context.read<GeneralCubit>();

    switch (action) {
      case _MenuAction.theme:
        generalCubit.toggleTheme();
        break;
      case _MenuAction.favorites:
        NavigationService.pushNamed(Routes.weatherFavorites);
        break;
      case _MenuAction.temperatureUnit:
        generalCubit.toggleTemperatureUnit();
        break;
      case _MenuAction.language:
        _showLanguageDialog(context);
        break;
    }
  }

  void _showLanguageDialog(BuildContext context) {
    final generalCubit = context.read<GeneralCubit>();
    final currentLang = LocalizationHelper.currentLocalName;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.language, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(LocalizationHelper.tr.selectLanguage),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLanguageOption(
                  context: context,
                  title: 'English',
                  subtitle: 'English Language',
                  value: 'en',
                  currentValue: currentLang,
                  flag: '🇬🇧',
                  onTap: () {
                    generalCubit.changeLocale('English');
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 12),
                _buildLanguageOption(
                  context: context,
                  title: 'العربية',
                  subtitle: 'اللغة العربية',
                  value: 'ar',
                  currentValue: currentLang,
                  flag: '🇸🇦',
                  onTap: () {
                    generalCubit.changeLocale('العربية');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(LocalizationHelper.tr.cancel),
              ),
            ],
          ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String value,
    required String currentValue,
    required String flag,
    required VoidCallback onTap,
  }) {
    final isSelected = value == currentValue;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? AppColors.primary : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.primary : null,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}

enum _MenuAction { theme, favorites, temperatureUnit, language }
