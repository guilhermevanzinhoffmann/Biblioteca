import 'package:biblioteca_app/models/login/login_request.dart';
import 'package:biblioteca_app/models/login/login_response.dart';
import 'package:biblioteca_app/services/api/custom_api_service.dart';
import 'package:biblioteca_app/services/storage/app_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginService {
  final CustomApiService _api = CustomApiService();
  final String _urlController = dotenv.get("API_BASE_URL");
  final _storage = AppStorageService();
  Future<LoginResponse> login(String email, String senha) async {
    try {
      var url = "$_urlController/Login/Login";
      var loginRequest = LoginRequest.criar(email, senha);
      var json = loginRequest.toJson();
      var resultJson = await _api.dio.post(url.toString(), data: json);
      var result = LoginResponse.fromJson(resultJson.data);
      if (result.sucesso) {
        await _storage.getString("token", result.token);
      }
      return result;
    } catch (e) {
      return LoginResponse.erro(e.toString());
    }
  }

  Future<LoginResponse> loginRefresh(String email, String senha) async {
    try {
      var token = await _storage.getString("token");
      if (token.isNotEmpty) {
        _api.dio.options.headers["Authorization"] = "Bearer $token";
      }
      var url = "$_urlController/Login/Refresh-Login";
      var resultJson = await _api.dio.post(url.toString());
      var result = LoginResponse.fromJson(resultJson.data);
      if (result.sucesso) {
        await _storage.setString("token", result.refreshToken);
      }
      return result;
    } catch (e) {
      return LoginResponse.erro(e.toString());
    }
  }
}
