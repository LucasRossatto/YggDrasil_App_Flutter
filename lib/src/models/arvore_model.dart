import 'package:equatable/equatable.dart';

class ArvoreModel extends Equatable {
  final int usuarioId;
  final String tagId;
  final String imagemURL;
  final String nome;
  final String familia;
  final String idadeAproximada;
  final String localizacao;
  final String mensagem;
  final int nota;
  final int tipo;

  const ArvoreModel({
    required this.usuarioId,
    required this.tagId,
    required this.imagemURL,
    required this.nome,
    required this.familia,
    required this.mensagem,
    required this.idadeAproximada,
    required this.localizacao,
    required this.nota,
    required this.tipo,
  });

  factory ArvoreModel.fromJson(Map<String, dynamic> json) {
    return ArvoreModel(
      usuarioId: json['usuarioId'] ?? 0,
      tagId: json['tagId'] ?? 0,
      imagemURL: json['imagemURL'] ?? '',
      nome: json['nome'] ?? '',
      familia: json['familia'] ?? '',
      idadeAproximada: json['idadeAproximada'] ?? '',
      localizacao: json['localizacao'] ?? '',
      nota: json['nota'] ?? 0,
      tipo: json['tipo'] ?? 0,
      mensagem: json['mensagem'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'tagId': tagId,
      'imagemURL': imagemURL,
      'nome': nome,
      'familia': familia,
      'idadeAproximada': idadeAproximada,
      'localizacao': localizacao,
      'nota': nota,
      'tipo': tipo,
      'mensagem': mensagem,
    };
  }

  ArvoreModel copyWith({
    int? usuarioId,
    String? tagId,
    String? imagemURL,
    String? nome,
    String? familia,
    String? idadeAproximada,
    String? localizacao,
    String? mensagem,
    int? nota,
    int? tipo,
  }) {
    return ArvoreModel(
      usuarioId: usuarioId ?? this.usuarioId,
      tagId: tagId ?? this.tagId,
      imagemURL: imagemURL ?? this.imagemURL,
      nome: nome ?? this.nome,
      mensagem: mensagem ?? this.mensagem,
      familia: familia ?? this.familia,
      idadeAproximada: idadeAproximada ?? this.idadeAproximada,
      localizacao: localizacao ?? this.localizacao,
      nota: nota ?? this.nota,
      tipo: tipo ?? this.tipo,
    );
  }

  @override
  List<Object?> get props => [
    usuarioId,
    tagId,
    imagemURL,
    nome,
    familia,
    idadeAproximada,
    localizacao,
    nota,
    tipo,
    mensagem,
  ];
}
