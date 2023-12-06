class LoginResponse {
  bool sucesso = false;
  String token = "";
  String refreshToken = "";
  DateTime dataExpiracao = DateTime.now();
  DateTime dataExpiracaoRefreshToken = DateTime.now();
  String erro = "";

  LoginResponse.erro(this.erro);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    sucesso = json['sucesso'] ?? false;
    token = json['token'] ?? "";
    refreshToken = json['refreshToken'] ?? "";
    dataExpiracao = json['dataExpiracao'] ?? DateTime.now();
    dataExpiracaoRefreshToken =
        json['dataExpiracaoRefreshToken'] ?? DateTime.now();
    erro = json['erro'] ?? "";
  }
}
