import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService {
  Future<void> setBool(String chave, bool valor) async {
    var storage = await SharedPreferences.getInstance();

    await storage.setBool(chave, valor);
  }

  Future<bool> getBool(String chave, [bool? defaultValue]) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getBool(chave) ?? (defaultValue ?? false);
  }

  Future<void> setString(String chave, String valor) async {
    var storage = await SharedPreferences.getInstance();

    await storage.setString(chave, valor);
  }

  Future<String> getString(String chave, [String defaultValue = '']) async {
    var storage = await SharedPreferences.getInstance();

    return storage.getString(chave) ?? defaultValue;
  }
}
