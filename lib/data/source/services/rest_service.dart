import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RestService {
  final Dio _dio;
  final Logger? logger;

  const RestService(this._dio, {this.logger});

  Future<String?> get({required String path}) async {
    try {
      final Response response = await _dio.get(path);
      if (response.statusCode == 200) {
        return response.data.toString();
      }
    } catch (e) {
      logger?.log(Level.error, e);
    }
    return null;
  }
}
