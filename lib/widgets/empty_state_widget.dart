import 'package:flutter/material.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Widget? action;
  final VoidCallback? onRefresh;

  const EmptyStateWidget({
    super.key,
    this.message,
    this.icon,
    this.action,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: AppSizes.iconXL * 2,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSizes.spacingM),
            Text(
              message ?? AppStrings.empty,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSizes.spacingL),
              action!,
            ],
            if (onRefresh != null) ...[
              const SizedBox(height: AppSizes.spacingL),
              TextButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
