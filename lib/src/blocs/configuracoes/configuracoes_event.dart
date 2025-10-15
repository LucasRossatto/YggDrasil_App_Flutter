import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConfiguracoesEvent extends Equatable {
  const ConfiguracoesEvent();

  @override
  List<Object?> get props => [];
}

class CarregarConfiguracoes extends ConfiguracoesEvent {}

class AlternarModoEscuro extends ConfiguracoesEvent {
  final ThemeMode tema;
  const AlternarModoEscuro(this.tema);

  @override
  List<Object?> get props => [tema];
}

class AlterarIdioma extends ConfiguracoesEvent {
  final String idioma;
  const AlterarIdioma(this.idioma);

  @override
  List<Object?> get props => [idioma];
}
