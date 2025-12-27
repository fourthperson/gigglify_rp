import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:gigglify_rp/data/source/prefs/prefs_data_source.dart';
import 'package:logger/logger.dart';

import 'package:gigglify_rp/app.dart';
import 'package:gigglify_rp/data/repo/choice_repo_impl.dart';
import 'package:gigglify_rp/data/repo/joke_repo_impl.dart';
import 'package:gigglify_rp/data/source/api/api_data_source.dart';
import 'package:gigglify_rp/data/source/db/db_data_source.dart';
import 'package:gigglify_rp/data/source/db/gig_db.dart';
import 'package:gigglify_rp/data/source/services/prefs_service.dart';
import 'package:gigglify_rp/data/source/services/rest_service.dart';
import 'package:gigglify_rp/domain/repository/choice_repository.dart';
import 'package:gigglify_rp/domain/repository/joke_repository.dart';
import 'package:gigglify_rp/domain/use_case/get_choice_use_case.dart';
import 'package:gigglify_rp/domain/use_case/get_joke_use_case.dart';
import 'package:gigglify_rp/domain/use_case/get_saved_jokes_use_case.dart';
import 'package:gigglify_rp/domain/use_case/save_choice_use_case.dart';
import 'package:gigglify_rp/domain/use_case/save_joke_use_case.dart';

part 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await initDependencies();

  runApp(GiglifyApp());
}
