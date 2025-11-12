import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/injection/injection_container.dart';
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
    final repository = InjectionContainer().countriesRepository;
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

  Widget _buildFlagSection(BuildContext context, String flagUrl, String cca2) {
    final theme = Theme.of(context);
    return Hero(
      tag: 'country_flag_$cca2',
      child: Container(
        width: double.infinity,
        height: 250,
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
      padding: const EdgeInsets.only(bottom: AppSizes.spacingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
        Wrap(
          spacing: AppSizes.spacingS,
          runSpacing: AppSizes.spacingS,
          children: timezones.map((timezone) {
            return _buildTimezoneChip(context, timezone);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimezoneChip(BuildContext context, String timezone) {
    final theme = Theme.of(context);
    return Chip(
      label: Text(timezone),
      backgroundColor: theme.colorScheme.primaryContainer,
      labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingS,
        vertical: AppSizes.paddingXS,
      ),
    );
  }
}
