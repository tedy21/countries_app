import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/injection/service_locator.dart';
import '../../../countries/domain/repositories/countries_repository.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../../../core/widgets/theme_toggle_button.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/empty_state_widget.dart';
import '../../../countries/presentation/pages/country_detail_page.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import '../widgets/favorite_list_item.dart';
import '../widgets/favorite_list_shimmer.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        favoritesRepository: getIt<FavoritesRepository>(),
        countriesRepository: getIt<CountriesRepository>(),
      )..add(const LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.favorites,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: const [
            ThemeToggleButton(),
          ],
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
              return const FavoriteListShimmer();
            }

            if (state is FavoritesLoading) {
              return const FavoriteListShimmer();
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

              return Column(
                children: [
                  if (state.hasPartialData)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingM,
                        vertical: AppSizes.paddingS,
                      ),
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Row(
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 20,
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: AppSizes.spacingS),
                          Expanded(
                            child: Text(
                              state.failedCount != null
                                  ? '${state.failedCount} favorite(s) could not be loaded. Showing cached data.'
                                  : AppStrings.favoritesPartialLoad,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTablet = constraints.maxWidth > 600;
                        final crossAxisCount = isTablet
                            ? (constraints.maxWidth / 400).floor().clamp(2, 4)
                            : 1;

                        if (isTablet) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<FavoritesBloc>()
                                  .add(const RefreshFavorites());
                            },
                            child: GridView.builder(
                              padding: const EdgeInsets.all(AppSizes.paddingM),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: AppSizes.spacingM,
                                mainAxisSpacing: AppSizes.spacingM,
                                childAspectRatio: 2.5,
                              ),
                              itemCount: state.favorites.length,
                              itemBuilder: (context, index) {
                                final country = state.favorites[index];
                                return FavoriteListItem(
                                  country: country,
                                  onTap: () =>
                                      _onCountryTap(context, country.cca2),
                                  onRemoveFavorite: () =>
                                      _onRemoveFavorite(context, country.cca2),
                                );
                              },
                            ),
                          );
                        } else {
                          return RefreshIndicator(
                            onRefresh: () async {
                              context
                                  .read<FavoritesBloc>()
                                  .add(const RefreshFavorites());
                            },
                            child: ListView.separated(
                              itemCount: state.favorites.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox.shrink(),
                              itemBuilder: (context, index) {
                                final country = state.favorites[index];
                                return FavoriteListItem(
                                  country: country,
                                  onTap: () =>
                                      _onCountryTap(context, country.cca2),
                                  onRemoveFavorite: () =>
                                      _onRemoveFavorite(context, country.cca2),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.dividerColor,
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
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
