import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/empty_state_widget.dart';
import '../../../countries/presentation/pages/country_detail_page.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import '../widgets/favorite_list_item.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final injectionContainer = InjectionContainer();
    return BlocProvider(
      create: (context) => FavoritesBloc(
        favoritesRepository: injectionContainer.favoritesRepository,
        countriesRepository: injectionContainer.countriesRepository,
      )..add(const LoadFavorites()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            AppStrings.favorites,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          buildWhen: (previous, current) {
            return previous != current;
          },
          builder: (context, state) {
            if (state is FavoritesInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<FavoritesBloc>().add(const LoadFavorites());
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FavoritesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FavoritesError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<FavoritesBloc>().add(const LoadFavorites());
                },
              );
            }

            if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return const EmptyStateWidget(
                  message: AppStrings.noFavorites,
                  icon: Icons.favorite_border,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FavoritesBloc>().add(const RefreshFavorites());
                },
                child: ListView.separated(
                  itemCount: state.favorites.length,
                  separatorBuilder: (context, index) => const SizedBox.shrink(),
                  itemBuilder: (context, index) {
                    final country = state.favorites[index];
                    return FavoriteListItem(
                      country: country,
                      onTap: () => _onCountryTap(context, country.cca2),
                      onRemoveFavorite: () =>
                          _onRemoveFavorite(context, country.cca2),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  void _onCountryTap(BuildContext context, String cca2) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CountryDetailPage(cca2: cca2),
      ),
    );
  }

  void _onRemoveFavorite(BuildContext context, String cca2) {
    context.read<FavoritesBloc>().add(RemoveFavorite(cca2));
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pop();
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.surface,
        elevation: 0,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
