import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../widgets/shimmer_loader.dart';

class CountryListShimmer extends StatelessWidget {
  const CountryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingS,
          ),
          constraints: const BoxConstraints(
            minHeight: 72,
          ),
          child: const Row(
            children: [
              ShimmerLoader(
                width: 60,
                height: 40,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              SizedBox(width: AppSizes.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShimmerLoader(
                      width: double.infinity,
                      height: 16,
                    ),
                    SizedBox(height: 4),
                    ShimmerLoader(
                      width: 150,
                      height: 14,
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSizes.spacingS),
              ShimmerLoader(
                width: 40,
                height: 40,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ],
          ),
        );
      },
    );
  }
}
