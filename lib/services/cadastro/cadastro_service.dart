import 'package:biblioteca_app/models/cadastro/cadastro_request.dart';
import 'package:biblioteca_app/models/cadastro/cadastro_response.dart';
import 'package:biblioteca_app/services/api/custom_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CadastroService {
  final CustomApiService _api = CustomApiService();
  final String _urlController = dotenv.get("API_BASE_URL");
  Future<CadastroResponse> cadastrar(String email, String senha) async {
    try {
      var url = "$_urlController/Login/Cadastro";
      var cadastroRequest = CadastroRequest.criar(email, senha);
      var json = cadastroRequest.toJson();
      var resultJson = await _api.dio.post(url.toString(), data: json);

      if (resultJson.statusCode! >= 400) {
        return CadastroResponse.fromJson(resultJson.data);
      }

      var result = CadastroResponse.fromJson(resultJson.data);
      return result;
    } catch (e) {
      if (e is DioException) {
        DioException error = e;
        return CadastroResponse.fromJson(error.response?.data);
      }
      return CadastroResponse.erro(e.toString());
    }
  }
}
