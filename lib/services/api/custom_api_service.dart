import 'package:biblioteca_app/services/storage/app_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomApiService {
  final _dio = Dio();
  Dio get dio => _dio;

  CustomApiService() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.headers["Accept"] = "*/*";
    _dio.options.headers["Accept-Encoding"] = "gzip, deflate, br";
    _dio.options.headers["Connection"] = "keep-alive";
    _dio.options.baseUrl = dotenv.get("API_BASE_URL");
    _dio.options.followRedirects = true;
    _dio.options.maxRedirects = 10;
    _dio.options.validateStatus = (status) {
      return status! >= 200 && status < 400;
    };
    _getToken();
  }

  Future<void> _getToken() async {
    var storage = AppStorageService();
    var token = await storage.getString("token");

    if (token.isNotEmpty) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
  }
}
