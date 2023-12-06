class LoginRequest {
  String email = "";
  String senha = "";

  LoginRequest.criar(this.email, this.senha);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["senha"] = senha;
    return data;
  }
}
