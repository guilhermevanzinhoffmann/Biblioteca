import 'package:biblioteca_app/services/storage/app_storage_service.dart';
import 'package:biblioteca_app/shared/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({super.key});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  late bool temaEscuro;
  bool carregando = true;
  AppStorageService storageService = AppStorageService();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    setState(() {
      carregando = true;
    });
    temaEscuro = await storageService.getBool('tema', false);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return carregando
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text("Configurações"),
                  centerTitle: true,
                ),
                body: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView(
                    children: [
                      SwitchListTile(
                          title: const Text("Tema Escuro"),
                          value: temaEscuro,
                          onChanged: (bool value) async {
                            temaEscuro = value;
                            await storageService.setBool('tema', temaEscuro);
                            if (!context.mounted) return;
                            context.read<ThemeProvider>().setTheme(temaEscuro);
                            setState(() {});
                          })
                    ],
                  ),
                )));
  }
}
