import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import 'app_button.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppSizes.iconXL * 2,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSizes.spacingM),
            Text(
              message ?? AppStrings.errorLoadingData,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSizes.spacingL),
              AppButton(
                text: AppStrings.retry,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
