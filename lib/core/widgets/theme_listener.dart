import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/theme_bloc.dart';
import '../theme/theme_state.dart';

class ThemeListener extends StatefulWidget {
  final Widget child;

  const ThemeListener({
    super.key,
    required this.child,
  });

  @override
  State<ThemeListener> createState() => _ThemeListenerState();
}

class _ThemeListenerState extends State<ThemeListener>
    with WidgetsBindingObserver {
  Brightness _currentBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (!mounted) return;

    final newBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (_currentBrightness != newBrightness) {
      setState(() {
        _currentBrightness = newBrightness;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) {
        if (current.themeMode == ThemeMode.system) {
          final platformBrightness =
              WidgetsBinding.instance.platformDispatcher.platformBrightness;
          if (_currentBrightness != platformBrightness) {
            _currentBrightness = platformBrightness;
            return true;
          }
        }
        return previous.themeMode != current.themeMode;
      },
      builder: (context, state) {
        return widget.child;
      },
    );
  }
}
