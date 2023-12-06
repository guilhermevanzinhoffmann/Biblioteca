import 'package:biblioteca_app/shared/drawer/pages/configuracao_page.dart';
import 'package:biblioteca_app/shared/drawer/pages/login_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Câmera"),
                        leading: const Icon(Icons.camera_alt),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Galeria"),
                        leading: const Icon(Icons.image),
                      )
                    ]);
                  });
            },
            child: UserAccountsDrawerHeader(
              accountName: const Text("Usuario"),
              accountEmail: const Text("guilhermevanzin@gmail.com"),
              decoration: const BoxDecoration(color: Colors.orange),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                    'https://hermes.digitalinnovation.one/assets/diome/logo.png'),
              ),
            ),
          ),
          InkWell(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: double.infinity,
                  child: const Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Configurações"),
                    ],
                  )),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfiguracaoPage()));
              }),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: const Row(
                  children: [Icon(Icons.exit_to_app), Text("Sair")],
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: const Text("Biblioteca"),
                        content: const Wrap(
                          children: [Text("Deseja sair?")],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Não")),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text("Sim"))
                        ]);
                  });
            },
          ),
        ],
      ),
    );
  }
}
