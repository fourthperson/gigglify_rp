import 'dart:convert';

import 'package:gigglify_rp/data/entity/api/joke_response.dart';
import 'package:gigglify_rp/data/source/services/rest_service.dart';
import 'package:logger/logger.dart';

abstract class ApiDataSource {
  Future<JokeResponseModel?> getJoke(String path);
}

class ApiDataSourceImpl extends ApiDataSource {
  final RestService _restService;
  final Logger? logger;

  ApiDataSourceImpl(this._restService, {this.logger});

  @override
  Future<JokeResponseModel?> getJoke(String path) async {
    try {
      final String? json = await _restService.get(path: path);

      if (json == null) return null;

      final JokeResponseModel model = JokeResponseModel.fromJson(
        jsonDecode(json),
      );

      if (!model.error) {
        return model;
      }
    } catch (e) {
      logger?.log(Level.error, e);
    }
    return null;
  }
}
