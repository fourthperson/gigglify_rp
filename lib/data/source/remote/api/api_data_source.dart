import 'dart:convert';

import 'package:gigglify_rp/data/model/api/joke_response.dart';
import 'package:gigglify_rp/data/source/remote/api/rest_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class ApiDataSource {
  Future<JokeResponseModel?> getJoke(String path);
}

@LazySingleton(as: ApiDataSource)
class ApiDataSourceImpl extends ApiDataSource {
  final RestService _restService;
  final Logger? _logger;

  ApiDataSourceImpl({required RestService restService, required Logger? logger})
    : _restService = restService,
      _logger = logger;

  @override
  Future<JokeResponseModel?> getJoke(String path) async {
    try {
      final String? json = await _restService.get(path: path);
      if (json == null) return null;

      final JokeResponseModel model = JokeResponseModel.fromJson(
        jsonDecode(json),
      );
      if (model.error) return null;

      return model;
    } catch (e) {
      _logger?.e(e);
    }
    return null;
  }
}
