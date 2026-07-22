import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigglify_rp/di.dart';
import 'package:gigglify_rp/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await configureDependencies();

  runApp(GiglifyApp());
}
