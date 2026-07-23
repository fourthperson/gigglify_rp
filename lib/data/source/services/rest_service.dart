import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class RestService {
  final Dio _dio;
  final Logger? _logger;

  RestService({required Dio dio, required Logger? logger})
    : _dio = dio,
      _logger = logger;

  Future<String?> get({required String path}) async {
    try {
      final Response response = await _dio.get(path);
      if (response.statusCode == 200) {
        return response.data.toString();
      }
    } catch (e) {
      _logger?.e(e);
    }
    return null;
  }
}
