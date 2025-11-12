import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/injection/service_locator.dart';
import '../../domain/repositories/countries_repository.dart';
import '../../../../core/widgets/theme_toggle_button.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/app_loader.dart';
import '../bloc/country_detail_bloc.dart';
import '../bloc/country_detail_event.dart';
import '../bloc/country_detail_state.dart';
import '../../domain/entities/country_details.dart';
import '../widgets/detail_shimmer.dart';

class CountryDetailPage extends StatelessWidget {
  final String cca2;

  const CountryDetailPage({
    super.key,
    required this.cca2,
  });

  @override
  Widget build(BuildContext context) {
    final repository = getIt<CountriesRepository>();
    return BlocProvider(
      create: (context) => CountryDetailBloc(repository: repository)
        ..add(LoadCountryDetail(cca2)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: BlocBuilder<CountryDetailBloc, CountryDetailState>(
            builder: (context, state) {
              if (state is CountryDetailLoaded) {
                return Text(
                  state.country.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          elevation: 0,
          centerTitle: true,
          actions: const [
            ThemeToggleButton(),
          ],
        ),
        body: BlocBuilder<CountryDetailBloc, CountryDetailState>(
          builder: (context, state) {
            if (state is CountryDetailLoading) {
              return const DetailShimmer();
            }

            if (state is CountryDetailError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<CountryDetailBloc>().add(
                        LoadCountryDetail(cca2),
                      );
                },
              );
            }

            if (state is CountryDetailLoaded) {
              return _buildContent(context, state.country);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CountryDetails country) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        if (isTablet) {
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildFlagSection(
                          context, country.flag, country.cca2),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.paddingL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildKeyStatistics(context, country),
                            const SizedBox(height: AppSizes.spacingXL),
                            _buildTimezoneSection(context, country.timezones),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFlagSection(context, country.flag, country.cca2),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildKeyStatistics(context, country),
                      const SizedBox(height: AppSizes.spacingXL),
                      _buildTimezoneSection(context, country.timezones),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildFlagSection(BuildContext context, String flagUrl, String cca2) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final flagHeight = isTablet ? 400.0 : 250.0;

        return Hero(
          tag: 'country_flag_$cca2',
          child: Container(
            width: double.infinity,
            height: flagHeight,
            color: theme.dividerColor,
            child: Image.network(
              flagUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: AppLoader(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: theme.dividerColor,
                  child: Center(
                    child: Icon(
                      Icons.flag,
                      size: 64,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildKeyStatistics(BuildContext context, CountryDetails country) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSizes.spacingM),
        _buildStatRow(
            context,
            'Area',
            country.area != null
                ? '${NumberFormatter.formatNumber(country.area!.toInt())} sq km'
                : 'N/A'),
        _buildStatRow(
          context,
          AppStrings.population,
          NumberFormatter.formatNumber(country.population),
        ),
        _buildStatRow(context, AppStrings.region, country.region),
        _buildStatRow(context, AppStrings.subregion, country.subregion),
      ],
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimezoneSection(BuildContext context, List<String> timezones) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Timezones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSizes.spacingM),
        if (timezones.isEmpty)
          Text(
            'N/A',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          )
        else
          Wrap(
            spacing: AppSizes.spacingS,
            runSpacing: AppSizes.spacingS,
            children: timezones
                .map((timezone) => _buildTimezoneChip(context, timezone))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildTimezoneChip(BuildContext context, String timezone) {
    final theme = Theme.of(context);
    final formattedTimezone = _formatTimezone(timezone);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
      ),
      child: Text(
        formattedTimezone,
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  String _formatTimezone(String timezone) {
    if (timezone.startsWith('UTC')) {
      final match = RegExp(r'UTC([+-]\d{1,2})').firstMatch(timezone);
      if (match != null) {
        return 'UTC ${match.group(1)}';
      }
      return timezone;
    }

    final offsetPattern = RegExp(r'([+-]\d{1,2})(?::(\d{2}))?');
    final match = offsetPattern.firstMatch(timezone);

    if (match != null) {
      final hours = match.group(1);
      return 'UTC $hours';
    }

    final parts = timezone.split('/');
    if (parts.length > 1) {
      final location = parts[1];
      final offsetMatch = offsetPattern.firstMatch(location);
      if (offsetMatch != null) {
        return 'UTC ${offsetMatch.group(1)}';
      }
    }

    return timezone;
  }
}
