import 'package:equatable/equatable.dart';

class AvaliacaoModel extends Equatable {
  final String tag;
  final int usuarioId;
  final String imagemValidacao;
  final String condicaoAtual;
  final String comentario;
  final DateTime dataAvaliacao;
  final int nota;

  const AvaliacaoModel({
    required this.tag,
    required this.usuarioId,
    required this.imagemValidacao,
    required this.condicaoAtual,
    required this.comentario,
    required this.dataAvaliacao,
    required this.nota,
  });

  factory AvaliacaoModel.init() {
    return AvaliacaoModel(
      tag: '',
      usuarioId: 0,
      imagemValidacao: '',
      condicaoAtual: '',
      comentario: '',
      dataAvaliacao: DateTime.now(),
      nota: 0,
    );
  }

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return AvaliacaoModel(
      tag: json['tag'] ?? '',
      usuarioId: json['usuarioId'] ?? 0,
      imagemValidacao: json['imagemValidacao'] ?? '',
      condicaoAtual: json['condicaoAtual'] ?? '',
      comentario: json['comentario'] ?? '',
      dataAvaliacao: json['dataAvaliacao'] != null
          ? DateTime.parse(json['dataAvaliacao'])
          : DateTime.now(),
      nota: json['nota'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'usuarioId': usuarioId,
      'imagemValidacao': imagemValidacao,
      'condicaoAtual': condicaoAtual,
      'comentario': comentario,
      'dataAvaliacao': dataAvaliacao.toIso8601String(),
      'nota': nota,
    };
  }

  AvaliacaoModel copyWith({
    String? tag,
    int? usuarioId,
    String? imagemValidacao,
    String? condicaoAtual,
    String? comentario,
    DateTime? dataAvaliacao,
    int? nota,
  }) {
    return AvaliacaoModel(
      tag: tag ?? this.tag,
      usuarioId: usuarioId ?? this.usuarioId,
      imagemValidacao: imagemValidacao ?? this.imagemValidacao,
      condicaoAtual: condicaoAtual ?? this.condicaoAtual,
      comentario: comentario ?? this.comentario,
      dataAvaliacao: dataAvaliacao ?? this.dataAvaliacao,
      nota: nota ?? this.nota,
    );
  }

  @override
  List<Object?> get props => [
        tag,
        usuarioId,
        imagemValidacao,
        condicaoAtual,
        comentario,
        dataAvaliacao,
        nota,
      ];
}
