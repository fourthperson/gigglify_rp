import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/navigation/route_handler.dart';
import 'package:gigglify_rp/presentation/providers/theme_notifier.dart'; // Import the updated theme_notifier
import 'package:gigglify_rp/presentation/theme/theme.dart';

class GiglifyApp extends ConsumerStatefulWidget {
  const GiglifyApp({super.key});

  @override
  ConsumerState<GiglifyApp> createState() => _GiglifyAppState();
}

class _GiglifyAppState extends ConsumerState<GiglifyApp> {
  final AppRouter _router = AppRouter();

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    ref.read(themeProvider.notifier).loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = ref.watch(resolvedThemeProvider);

    return MaterialApp.router(
      routerConfig: _router.config(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
    );
  }
}
