import 'package:biblioteca_app/models/login/login_response.dart';
import 'package:biblioteca_app/pages/cadastro_page.dart';
import 'package:biblioteca_app/pages/home_page.dart';
import 'package:biblioteca_app/services/login/login_service.dart';
import 'package:biblioteca_app/shared/image_path.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginService = LoginService();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  bool isObscureText = true;
  bool esperandoRespostaLogin = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 254),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 7,
                  child: Image.asset(ImagePath.library),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Biblioteca",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Faça seu login ou cadastre-se",
                style: TextStyle(fontSize: 14, color: Colors.black)),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 30,
              alignment: Alignment.center,
              child: TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(top: -7),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 103, 80, 164))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 103, 80, 164))),
                  prefixIcon: Icon(Icons.email,
                      color: Color.fromARGB(255, 103, 80, 164)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: TextField(
                    obscureText: isObscureText,
                    controller: senhaController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: "Senha",
                        hintStyle: const TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.only(top: -4),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 103, 80, 164))),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 103, 80, 164))),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 103, 80, 164),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => {
                            setState(
                              () => isObscureText = !isObscureText,
                            )
                          },
                          child: Icon(isObscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )))),
            const SizedBox(
              height: 30,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                height: 30,
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: esperandoRespostaLogin
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          onPressed: () async {
                            setState(() {
                              esperandoRespostaLogin = true;
                            });
                            LoginResponse response = await _loginService.login(
                                emailController.text.trim(),
                                senhaController.text.trim());
                            setState(() {
                              esperandoRespostaLogin = false;
                            });
                            if (response.sucesso) {
                              if (!context.mounted) return;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            } else {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(response.erro)));
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 103, 80, 164)),
                          ),
                          child: const Text('Entrar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))),
                )),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 30,
              alignment: Alignment.center,
              child: const Text('Esqueci minha senha',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const CadastroPage()));
                  },
                  child: const Text('Criar conta',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w900))),
            ),
            const SizedBox(height: 60)
          ]),
        ),
      ),
    ));
  }
}
