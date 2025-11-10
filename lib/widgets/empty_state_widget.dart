import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    this.message,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: AppSizes.iconXL * 2,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppSizes.spacingM),
            Text(
              message ?? AppStrings.empty,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSizes.spacingL),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
