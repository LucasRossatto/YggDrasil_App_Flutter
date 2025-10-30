import 'package:equatable/equatable.dart';
import 'package:YggDrasil/src/models/tag_model.dart';

class ArvoreModel extends Equatable {
  final int id;
  final int usuarioId;
  final String tagId;
  final TagModel tag;
  final String imagemURL;
  final String nome;
  final String familia;
  final String idadeAproximada;
  final String localizacao;
  final String mensagem;
  final int nota;
  final int tipo; // 1- Não Frutifera, 2 - Frutifera
  final double sccAcumulado;
  final double sccGerado;
  final double sccLiberado;
  final String ultimaFiscalizacao;
  final String ultimaValidacao;
  final String ultimaAtualizacaoImagem;

  const ArvoreModel({
    required this.tag,
    required this.id,
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
    required this.sccAcumulado,
    required this.sccGerado,
    required this.sccLiberado,
    required this.ultimaFiscalizacao,
    required this.ultimaValidacao,
    required this.ultimaAtualizacaoImagem,
  });

  factory ArvoreModel.fromJson(Map<String, dynamic> json) {
    return ArvoreModel(
      id: json['id'] ?? 0,
      usuarioId: json['usuarioId'] ?? 0,
      tagId: json['tagId'].toString(),
      imagemURL: json['imagemURL'] ?? '',
      nome: json['nome'] ?? '',
      familia: json['familia'] ?? '',
      idadeAproximada: json['idadeAproximada'] ?? '',
      localizacao: json['localizacao'] ?? '',
      nota: json['nota'] ?? 0,
      tipo: json['tipo'] ?? 0,
      mensagem: json['mensagem'] ?? '',
      sccAcumulado: json['sccAcumulado'],
      sccGerado: json['sccGerado'],
      sccLiberado: json['sccLiberado'],
      ultimaFiscalizacao: json['ultimaFiscalizacao'],
      ultimaValidacao: json['ultimaValidacao'],
      ultimaAtualizacaoImagem: json['ultimaAtualizacaoImagem'],
      tag: json['tag'] != null
          ? TagModel.fromJson(json['tag'])
          : TagModel(id: 0, epc: '', codigo: '', hash: '', status: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag.toJson(),
      'id': id,
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
    TagModel? tag,
    int? id,
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
    double? sccAcumulado,
    double? sccGerado,
    double? sccLiberado,
    String? ultimaFiscalizacao,
    String? ultimaValidacao,
    String? ultimaAtualizacaoImagem,
  }) {
    return ArvoreModel(
      tag: tag ?? this.tag,
      id: id ?? this.id,
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
      sccAcumulado: sccAcumulado ?? this.sccAcumulado,
      sccGerado: sccGerado ?? this.sccGerado,
      sccLiberado: sccLiberado ?? this.sccLiberado,
      ultimaFiscalizacao: ultimaFiscalizacao ?? this.ultimaFiscalizacao,
      ultimaValidacao: ultimaValidacao ?? this.ultimaValidacao,
      ultimaAtualizacaoImagem:
          ultimaAtualizacaoImagem ?? this.ultimaAtualizacaoImagem,
    );
  }

  String getTipo(int tipo) {
  if (tipo == 1) {
    return "Não-frutífera";
  } else if (tipo == 2) {
    return "Frutífera";
  } else {
    return "Desconhecido";
  }
}

  @override
  List<Object?> get props => [
    tag,
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
    sccAcumulado,
    sccGerado,
    sccLiberado,
    ultimaFiscalizacao,
    ultimaValidacao,
    ultimaAtualizacaoImagem,
  ];
}
