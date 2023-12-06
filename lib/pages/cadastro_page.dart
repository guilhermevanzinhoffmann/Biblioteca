import 'package:biblioteca_app/services/cadastro/cadastro_service.dart';
import 'package:biblioteca_app/shared/drawer/pages/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool esperandoRespostaCadastro = false;
  CadastroService service = CadastroService();
  TextEditingController emailController = TextEditingController(text: "");
  FancyPasswordController senhaController = FancyPasswordController();
  TextEditingController senhaContentController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 254),
      appBar: AppBar(
        title: const Text("Cadastro"),
        centerTitle: true,
      ),
      body: Column(children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: TextField(
            onChanged: (value) => setState(() {}),
            style: const TextStyle(color: Colors.black),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorText: EmailValidator.validate(emailController.text)
                  ? null
                  : "email inválido",
              label: const Text("Email"),
              labelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400),
              contentPadding: const EdgeInsets.only(top: -7),
              enabledBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 103, 80, 164))),
              focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 103, 80, 164))),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: FancyPasswordField(
            controller: senhaContentController,
            onChanged: (value) => setState(() {}),
            hasStrengthIndicator: false,
            style: const TextStyle(color: Colors.black),
            showPasswordIcon: const Icon(Icons.visibility),
            hidePasswordIcon: const Icon(Icons.visibility_off),
            passwordController: senhaController,
            decoration: const InputDecoration(
              label: Text("Senha"),
              labelStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              contentPadding: EdgeInsets.only(top: -4),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 103, 80, 164))),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 103, 80, 164))),
            ),
            validationRules: {
              DigitValidationRule(customText: "Possui ao menos um dígito"),
              SpecialCharacterValidationRule(
                  customText: "Possui ao menos um caractere especial"),
              UppercaseValidationRule(customText: "Possui letra maiúscula"),
              LowercaseValidationRule(customText: "Possui letra minúscula"),
              MinCharactersValidationRule(6, customText: "Mínimo 6 caracteres")
            },
            validationRuleBuilder: (rules, value) {
              if (value.isEmpty) {
                return const SizedBox.shrink();
              }
              return ListView(
                shrinkWrap: true,
                children: rules
                    .map(
                      (rule) => rule.validate(value)
                          ? Row(
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  rule.name,
                                  style: const TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  rule.name,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                    )
                    .toList(),
              );
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        esperandoRespostaCadastro
            ? const Center(child: CircularProgressIndicator())
            : TextButton(
                onPressed: senhaController.areAllRulesValidated &&
                        senhaContentController.text.isNotEmpty &&
                        EmailValidator.validate(emailController.text)
                    ? () async {
                        setState(() {
                          esperandoRespostaCadastro = true;
                        });
                        var result = await service.cadastrar(
                            emailController.text.trim(),
                            senhaContentController.text.trim());

                        setState(() {
                          esperandoRespostaCadastro = false;
                        });

                        if (result.sucesso) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Cadastro efetuado com sucesso!")));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        } else {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.erro)));
                        }
                      }
                    : null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                      senhaController.areAllRulesValidated &&
                              senhaContentController.text.isNotEmpty &&
                              EmailValidator.validate(emailController.text)
                          ? const Color.fromRGBO(103, 80, 164, 1)
                          : const Color.fromRGBO(188, 184, 201, 1)),
                ),
                child: const Text('Cadastrar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400))),
      ]),
    ));
  }
}
