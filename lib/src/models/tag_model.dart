import 'package:equatable/equatable.dart';

class TagModel extends Equatable {
  final int id;
  final String epc;
  final String codigo;
  final String hash;
  final int status;

  const TagModel({
    required this.id,
    required this.epc,
    required this.codigo,
    required this.hash,
    required this.status,
  });

  /// Construtor inicial padrão
  factory TagModel.init() {
    return const TagModel(
      id: 0,
      epc: '',
      codigo: '',
      hash: '',
      status: 0,
    );
  }

  /// Criar a partir de JSON
  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'] ?? 0,
      epc: json['epc'] ?? '',
      codigo: json['codigo'] ?? '',
      hash: json['hash'] ?? '',
      status: json['status'] ?? 0,
    );
  }

  /// Converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'epc': epc,
      'codigo': codigo,
      'hash': hash,
      'status': status,
    };
  }

  /// Atualizar parcialmente
  TagModel copyWith({
    int? id,
    String? epc,
    String? codigo,
    String? hash,
    int? status,
  }) {
    return TagModel(
      id: id ?? this.id,
      epc: epc ?? this.epc,
      codigo: codigo ?? this.codigo,
      hash: hash ?? this.hash,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, epc, codigo, hash, status];
}
