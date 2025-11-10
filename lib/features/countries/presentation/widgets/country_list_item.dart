import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../models/country_summary.dart';

class CountryListItem extends StatelessWidget {
  final CountrySummary country;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const CountryListItem({
    super.key,
    required this.country,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  String _formatPopulation(int population) {
    if (population >= 1000000) {
      final millions = population / 1000000;
      return '${millions.toStringAsFixed(millions % 1 == 0 ? 0 : 1)}M';
    } else if (population >= 1000) {
      final thousands = population / 1000;
      return '${thousands.toStringAsFixed(thousands % 1 == 0 ? 0 : 1)}K';
    }
    return population.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primary.withValues(alpha: 0.1),
        highlightColor: AppColors.primary.withValues(alpha: 0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingS,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.border,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
                child: Image.network(
                  country.flag,
                  width: 60,
                  height: 40,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 60,
                      height: 40,
                      color: AppColors.border,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.textHint,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 40,
                      color: AppColors.border,
                      child: const Icon(
                        Icons.flag,
                        color: AppColors.textHint,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSizes.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      country.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Population: ${_formatPopulation(country.population)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.spacingS),
              IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  country.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: country.isFavorite
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
