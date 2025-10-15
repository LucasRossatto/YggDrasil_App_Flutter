import 'package:equatable/equatable.dart';
enum AppTema { claro, escuro, sistema }

class ConfiguracoesState extends Equatable {
  final AppTema tema;
  final String idioma;
  final bool carregando;

  const ConfiguracoesState({
    required this.tema,
    this.idioma = 'pt',
    this.carregando = false,
  });

  ConfiguracoesState copyWith({
    AppTema? tema,
    String? idioma,
    bool? carregando,
  }) {
    return ConfiguracoesState(
      tema: tema ?? this.tema,
      idioma: idioma ?? this.idioma,
      carregando: carregando ?? this.carregando,
    );
  }

  @override
  List<Object> get props => [
        tema,
        idioma,
        carregando,
      ];
}
