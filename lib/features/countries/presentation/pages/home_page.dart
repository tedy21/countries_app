import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/empty_state_widget.dart';
import '../bloc/countries_bloc.dart';
import '../bloc/countries_event.dart';
import '../bloc/countries_state.dart';
import '../widgets/country_list_item.dart';
import '../widgets/country_list_shimmer.dart';
import 'country_detail_page.dart';

class _SearchTextField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchTextField({
    required this.initialValue,
    required this.onChanged,
    required this.onClear,
  });

  @override
  State<_SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<_SearchTextField> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _hasText = widget.initialValue.isNotEmpty;
    _controller.addListener(() {
      final hasText = _controller.text.isNotEmpty;
      if (_hasText != hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
    });
  }

  @override
  void didUpdateWidget(_SearchTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.initialValue,
        selection: TextSelection.collapsed(offset: widget.initialValue.length),
      );
      _hasText = widget.initialValue.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Search for a country',
        hintStyle: const TextStyle(
          color: AppColors.textHint,
          fontSize: 14,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textSecondary,
          size: 20,
        ),
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
                onPressed: () {
                  _controller.clear();
                  widget.onClear();
                },
              )
            : null,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingM,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          AppStrings.countries,
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
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: BlocBuilder<CountriesBloc, CountriesState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                if (state is CountriesInitial) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<CountriesBloc>().add(const LoadCountries());
                  });
                  return const CountryListShimmer();
                }

                if (state is CountriesLoading) {
                  return const CountryListShimmer();
                }

                if (state is CountriesError) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () {
                      context.read<CountriesBloc>().add(const LoadCountries());
                    },
                  );
                }

                if (state is CountriesLoaded) {
                  if (state.countries.isEmpty) {
                    return const EmptyStateWidget(
                      message: AppStrings.noResults,
                      icon: Icons.search_off,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<CountriesBloc>()
                          .add(const RefreshCountries());
                    },
                    child: ListView.separated(
                      itemCount: state.countries.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox.shrink(),
                      itemBuilder: (context, index) {
                        final country = state.countries[index];
                        return CountryListItem(
                          country: country,
                          onTap: () => _onCountryTap(context, country.cca2),
                          onFavoriteToggle: () =>
                              _onFavoriteToggle(context, country.cca2),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      builder: (context, state) {
        final searchQuery = state is CountriesLoaded ? state.searchQuery : '';
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM,
            vertical: AppSizes.paddingS,
          ),
          color: AppColors.surface,
          child: _SearchTextField(
            initialValue: searchQuery,
            onChanged: (query) {
              context.read<CountriesBloc>().add(SearchCountries(query));
            },
            onClear: () {
              context.read<CountriesBloc>().add(const SearchCountries(''));
            },
          ),
        );
      },
    );
  }

  void _onCountryTap(BuildContext context, String cca2) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CountryDetailPage(cca2: cca2),
      ),
    );
  }

  void _onFavoriteToggle(BuildContext context, String cca2) {
    context.read<CountriesBloc>().add(ToggleFavorite(cca2));
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
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // TODO: Navigate to favorites page
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
