class CadastroRequest {
  String email = "";
  String senha = "";

  CadastroRequest.criar(this.email, this.senha);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["senha"] = senha;
    return data;
  }
}
