import 'package:equatable/equatable.dart';

class UsuarioModel extends Equatable{
  final int id;
  final String nome;
  final String email;

  const UsuarioModel({
    required this.id,
    required this.nome,
    required this.email,
  });

  factory UsuarioModel.init() {
    return UsuarioModel(id: 0, nome: '', email: '');
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'] ?? '',
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
    );
  }
  // Converter o objeto para JSON (para enviar para a API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
    };
  }

  // Atualizar parcialmente os campos
  UsuarioModel copyWith({
    int? id,
    String? nome,
    String? email,
    String? senha,
  }) {
    return UsuarioModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id,nome, email];
}
