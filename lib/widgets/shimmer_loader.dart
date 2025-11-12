import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/app_sizes.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  })  : assert(width >= 0),
        assert(height >= 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.dividerColor,
      highlightColor: theme.cardColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: theme.dividerColor,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusM),
        ),
      ),
    );
  }
}
