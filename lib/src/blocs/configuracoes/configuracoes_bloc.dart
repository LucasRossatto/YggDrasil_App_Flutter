import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_event.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_state.dart';
import 'package:yggdrasil_app/src/repository/configuracoes_repositorio.dart';

class ConfiguracoesBloc extends Bloc<ConfiguracoesEvent, ConfiguracoesState> {
  final ConfiguracoesRepositorio repositorio;

  ConfiguracoesBloc(this.repositorio)
      : super(const ConfiguracoesState(tema: AppTema.sistema)) {
    on<CarregarConfiguracoes>(_aoCarregarPreferencias);
    on<AlternarModoEscuro>(_aoAlternarModoEscuro);
    on<AlterarIdioma>(_aoAlterarIdioma);
  }

  Future<void> _aoCarregarPreferencias(
    CarregarConfiguracoes evento,
    Emitter<ConfiguracoesState> emitir,
  ) async {
    emitir(state.copyWith(carregando: true));

    final temaSalvo = await repositorio.obterTema();
    final idioma = await repositorio.obterIdioma();

    emitir(
      ConfiguracoesState(
        tema: _converterThemeModeParaAppTema(temaSalvo ?? ThemeMode.system),
        idioma: idioma,
        carregando: false,
      ),
    );
  }

  Future<void> _aoAlternarModoEscuro(
    AlternarModoEscuro evento,
    Emitter<ConfiguracoesState> emitir,
  ) async {
    await repositorio.definirTema(evento.tema);
    emitir(state.copyWith(tema: _converterThemeModeParaAppTema(evento.tema)));
  }

  Future<void> _aoAlterarIdioma(
    AlterarIdioma evento,
    Emitter<ConfiguracoesState> emitir,
  ) async {
    await repositorio.definirIdioma(evento.idioma);
    emitir(state.copyWith(idioma: evento.idioma));
  }

  AppTema _converterThemeModeParaAppTema(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return AppTema.claro;
      case ThemeMode.dark:
        return AppTema.escuro;
      case ThemeMode.system:
      return AppTema.sistema;
    }
  }
}
