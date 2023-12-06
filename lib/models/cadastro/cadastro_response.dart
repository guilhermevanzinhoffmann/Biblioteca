class CadastroResponse {
  bool sucesso = false;
  String erro = "";

  CadastroResponse.erro(this.erro);

  CadastroResponse.fromJson(Map<String, dynamic> json) {
    sucesso = json['sucesso'] ?? false;
    erro = json['erro'] ?? "";
  }
}
