import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesRepositorio {
  static const String _chaveTema = 'config_tema';
  static const String _chaveNotificacoes = 'config_notificacoes';
  static const String _chaveIdioma = 'config_idioma';

  /// Obtém o tema salvo (claro, escuro ou sistema)
  Future<ThemeMode?> obterTema() async {
    final prefs = await SharedPreferences.getInstance();
    final valor = prefs.getString(_chaveTema);

    switch (valor) {
      case 'claro':
        return ThemeMode.light;
      case 'escuro':
        return ThemeMode.dark;
      case 'sistema':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> definirTema(ThemeMode tema) async {
    final prefs = await SharedPreferences.getInstance();

    String valor;
    switch (tema) {
      case ThemeMode.light:
        valor = 'claro';
        break;
      case ThemeMode.dark:
        valor = 'escuro';
        break;
      case ThemeMode.system:
        valor = 'sistema';
        break;
    }

    await prefs.setString(_chaveTema, valor);
  }

  Future<bool> obterNotificacoes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_chaveNotificacoes) ?? true; // padrão: ativo
  }

  Future<void> definirNotificacoes(bool ativo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_chaveNotificacoes, ativo);
  }

  Future<String> obterIdioma() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_chaveIdioma) ?? 'pt';
  }

  /// Define o idioma
  Future<void> definirIdioma(String idioma) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_chaveIdioma, idioma);
  }
}
