import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_strings.dart';
import 'core/injection/service_locator.dart';
import 'features/countries/domain/repositories/countries_repository.dart';
import 'features/favorites/domain/repositories/favorites_repository.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'core/theme/theme_event.dart';
import 'core/theme/theme_state.dart';
import 'core/widgets/theme_listener.dart';
import 'features/countries/presentation/bloc/countries_bloc.dart';
import 'features/countries/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(const LoadTheme()),
      child: ThemeListener(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: AppStrings.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeState.themeMode,
              home: BlocProvider(
                create: (context) => CountriesBloc(
                  repository: getIt<CountriesRepository>(),
                  favoritesRepository: getIt<FavoritesRepository>(),
                ),
                child: const HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
