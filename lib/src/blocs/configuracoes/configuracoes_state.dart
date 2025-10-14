import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConfiguracoesState extends Equatable {
  final ThemeMode tema;
  final bool notificacoesAtivas;
  final String idioma;
  final bool carregando;

  const ConfiguracoesState({
    required this.tema,
    this.notificacoesAtivas = true,
    this.idioma = 'pt',
    this.carregando = false,
  });

  ConfiguracoesState copyWith({
    ThemeMode? tema,
    bool? notificacoesAtivas,
    String? idioma,
    bool? carregando,
  }) {
    return ConfiguracoesState(
      tema: tema ?? this.tema,
      notificacoesAtivas: notificacoesAtivas ?? this.notificacoesAtivas,
      idioma: idioma ?? this.idioma,
      carregando: carregando ?? this.carregando,
    );
  }

  @override
  List<Object> get props => [
        tema,
        notificacoesAtivas,
        idioma,
        carregando,
      ];
}
