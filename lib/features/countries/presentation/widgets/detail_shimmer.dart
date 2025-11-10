import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../widgets/shimmer_loader.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoader(
            width: double.infinity,
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerLoader(
                  width: 150,
                  height: 24,
                ),
                const SizedBox(height: AppSizes.spacingM),
                ...List.generate(
                    4,
                    (index) => const Padding(
                          padding: EdgeInsets.only(bottom: AppSizes.spacingS),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShimmerLoader(
                                width: 100,
                                height: 16,
                              ),
                              ShimmerLoader(
                                width: 150,
                                height: 16,
                              ),
                            ],
                          ),
                        )),
                const SizedBox(height: AppSizes.spacingL),
                const ShimmerLoader(
                  width: 120,
                  height: 24,
                ),
                const SizedBox(height: AppSizes.spacingM),
                Wrap(
                  spacing: AppSizes.spacingS,
                  runSpacing: AppSizes.spacingS,
                  children: List.generate(
                    2,
                    (index) => const ShimmerLoader(
                      width: 100,
                      height: 40,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
