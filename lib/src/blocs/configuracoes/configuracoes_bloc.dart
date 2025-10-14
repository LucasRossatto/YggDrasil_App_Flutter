import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_event.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_state.dart';
import 'package:yggdrasil_app/src/repository/configuracoes_repositorio.dart';

class ConfiguracoesBloc extends Bloc<ConfiguracoesEvent, ConfiguracoesState> {
  final ConfiguracoesRepositorio repositorio;

  ConfiguracoesBloc(this.repositorio)
      : super(const ConfiguracoesState(tema: ThemeMode.system)) {
    on<CarregarPreferencias>(_aoCarregarPreferencias);
    on<AlternarModoEscuro>(_aoAlternarModoEscuro);
    on<AlternarNotificacoes>(_aoAlternarNotificacoes);
    on<AlterarIdioma>(_aoAlterarIdioma);
  }

  Future<void> _aoCarregarPreferencias(
    CarregarPreferencias evento,
    Emitter<ConfiguracoesState> emitir,
  ) async {
    emitir(state.copyWith(carregando: true));

    final temaSalvo = await repositorio.obterTema();
    final notificacoes = await repositorio.obterNotificacoes();
    final idioma = await repositorio.obterIdioma();

    emitir(
      ConfiguracoesState(
        tema: temaSalvo ?? ThemeMode.system,
        notificacoesAtivas: notificacoes,
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
    emitir(state.copyWith(tema: evento.tema));
  }

  Future<void> _aoAlternarNotificacoes(
    AlternarNotificacoes evento,
    Emitter<ConfiguracoesState> emitir,
  ) async {
    await repositorio.definirNotificacoes(evento.ativo);
    emitir(state.copyWith(notificacoesAtivas: evento.ativo));
  }

  Future<void> _aoAlterarIdioma(
    AlterarIdioma evento,
    Emitter<ConfiguracoesState> emitir,
  ) async {
    await repositorio.definirIdioma(evento.idioma);
    emitir(state.copyWith(idioma: evento.idioma));
  }
}
