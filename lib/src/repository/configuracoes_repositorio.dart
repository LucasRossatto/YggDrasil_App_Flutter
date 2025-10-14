import 'package:flutter/material.dart';

class ConfiguracoesRepositorio {
  Future<ThemeMode?> obterTema() async {
    // Simula leitura local
    await Future.delayed(const Duration(milliseconds: 200));
    return ThemeMode.system;
  }

  Future<void> definirTema(ThemeMode tema) async {
    // Simula salvar local
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<bool> obterNotificacoes() async {
    return true;
  }

  Future<void> definirNotificacoes(bool ativo) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<String> obterIdioma() async {
    return 'pt';
  }

  Future<void> definirIdioma(String idioma) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
