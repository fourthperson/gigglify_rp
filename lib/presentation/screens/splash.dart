import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gigglify_rp/presentation/l10n/generated/l10n.dart';
import 'package:gigglify_rp/presentation/navigation/route_handler.gr.dart';
import 'package:gigglify_rp/presentation/theme/theme.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 2500),
      () => context.router.replace(const HomeRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final S strings = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(strings.app_name, style: textBold.copyWith(fontSize: 48)),
        ),
      ),
    );
  }
}
