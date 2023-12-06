import 'package:biblioteca_app/services/storage/app_storage_service.dart';
import 'package:biblioteca_app/shared/drawer/pages/login_page.dart';
import 'package:biblioteca_app/shared/themes/theme_provider.dart';
import 'package:biblioteca_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppStorageService storageService = AppStorageService();
  late bool temaEscuro;
  bool carregando = false;

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
    if (!context.mounted) return;
    context.read<ThemeProvider>().setTheme(temaEscuro);
    setState(() {
      carregando = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return carregando
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Biblioteca',
              themeMode: context.watch<ThemeProvider>().isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: const LoginPage(),
            );
    });
  }
}
