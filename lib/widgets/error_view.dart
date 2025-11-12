import 'package:flutter/material.dart';
import '../core/constants/app_sizes.dart';
import '../core/constants/app_strings.dart';
import '../core/errors/failures.dart';
import 'app_button.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  final Failure? failure;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.message,
    this.failure,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayMessage =
        failure?.displayMessage ?? message ?? AppStrings.errorLoadingData;
    final errorType = _getErrorType(failure);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getErrorIcon(errorType),
              size: AppSizes.iconXL * 2,
              color: _getErrorColor(errorType, theme),
            ),
            const SizedBox(height: AppSizes.spacingM),
            Text(
              displayMessage,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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

  ErrorType _getErrorType(Failure? failure) {
    if (failure == null) return ErrorType.unknown;
    if (failure is NetworkFailure) {
      return failure.isNoInternet ? ErrorType.noInternet : ErrorType.network;
    } else if (failure is ServerFailure) {
      return ErrorType.server;
    } else if (failure is CacheFailure) {
      return ErrorType.cache;
    }
    return ErrorType.unknown;
  }

  IconData _getErrorIcon(ErrorType type) {
    switch (type) {
      case ErrorType.noInternet:
        return Icons.wifi_off;
      case ErrorType.network:
        return Icons.signal_wifi_off;
      case ErrorType.server:
        return Icons.cloud_off;
      case ErrorType.cache:
        return Icons.storage;
      case ErrorType.unknown:
        return Icons.error_outline;
    }
  }

  Color _getErrorColor(ErrorType type, ThemeData theme) {
    switch (type) {
      case ErrorType.noInternet:
      case ErrorType.network:
        return theme.colorScheme.error;
      case ErrorType.server:
        return theme.colorScheme.error.withValues(alpha: 0.8);
      case ErrorType.cache:
        return theme.colorScheme.onSurface.withValues(alpha: 0.6);
      case ErrorType.unknown:
        return theme.colorScheme.error;
    }
  }
}

enum ErrorType {
  noInternet,
  network,
  server,
  cache,
  unknown,
}
