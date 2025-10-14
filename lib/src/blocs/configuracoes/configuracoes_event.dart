import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConfiguracoesEvent extends Equatable {
  const ConfiguracoesEvent();

  @override
  List<Object?> get props => [];
}

class CarregarPreferencias extends ConfiguracoesEvent {}

class AlternarModoEscuro extends ConfiguracoesEvent {
  final ThemeMode tema;
  const AlternarModoEscuro(this.tema);

  @override
  List<Object?> get props => [tema];
}

class AlternarNotificacoes extends ConfiguracoesEvent {
  final bool ativo;
  const AlternarNotificacoes(this.ativo);

  @override
  List<Object?> get props => [ativo];
}

class AlterarIdioma extends ConfiguracoesEvent {
  final String idioma;
  const AlterarIdioma(this.idioma);

  @override
  List<Object?> get props => [idioma];
}
