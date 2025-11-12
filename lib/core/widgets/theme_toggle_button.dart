import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/theme_bloc.dart';
import '../theme/theme_event.dart';
import '../theme/theme_state.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        IconData icon;
        String tooltip;

        switch (state.themeMode) {
          case ThemeMode.light:
            icon = Icons.light_mode;
            tooltip = 'Light Mode';
            break;
          case ThemeMode.dark:
            icon = Icons.dark_mode;
            tooltip = 'Dark Mode';
            break;
          case ThemeMode.system:
            icon = Icons.brightness_auto;
            tooltip = 'System Mode';
            break;
        }

        return IconButton(
          icon: Icon(icon),
          tooltip: tooltip,
          onPressed: () {
            context.read<ThemeBloc>().add(const ToggleTheme());
          },
        );
      },
    );
  }
}
