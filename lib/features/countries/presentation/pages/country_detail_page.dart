import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/number_formatter.dart';
import '../../../../core/injection/injection_container.dart';
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
        backgroundColor: AppColors.background,
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
                    color: AppColors.textPrimary,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
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
          _buildFlagSection(country.flag),
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildKeyStatistics(country),
                const SizedBox(height: AppSizes.spacingXL),
                _buildTimezoneSection(country.timezones),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlagSection(String flagUrl) {
    return Container(
      width: double.infinity,
      height: 250,
      color: AppColors.border,
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
            color: AppColors.border,
            child: const Center(
              child: Icon(
                Icons.flag,
                size: 64,
                color: AppColors.textHint,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKeyStatistics(CountryDetails country) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Statistics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.spacingM),
        _buildStatRow(
            'Area',
            country.area != null
                ? '${NumberFormatter.formatNumber(country.area!.toInt())} sq km'
                : 'N/A'),
        _buildStatRow(
          AppStrings.population,
          NumberFormatter.formatNumber(country.population),
        ),
        _buildStatRow(AppStrings.region, country.region),
        _buildStatRow(AppStrings.subregion, country.subregion),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimezoneSection(List<String> timezones) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Timezone',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.spacingM),
        Wrap(
          spacing: AppSizes.spacingS,
          runSpacing: AppSizes.spacingS,
          children: timezones.map((timezone) {
            return _buildTimezoneButton(timezone);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimezoneButton(String timezone) {
    final displayText = timezone.replaceAll('UTC', 'UTC');
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingS,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Text(
        displayText,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
