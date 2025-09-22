import 'package:equatable/equatable.dart';

class UsuarioModel extends Equatable{
  final String nome;
  final String email;

  const UsuarioModel({
    required this.nome,
    required this.email,
  });

  factory UsuarioModel.init() {
    return UsuarioModel(nome: '', email: '');
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Converter o objeto para JSON (para enviar para a API)
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'email': email,
    };
  }

  // Atualizar parcialmente os campos
  UsuarioModel copyWith({
    String? nome,
    String? email,
    String? senha,
  }) {
    return UsuarioModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [nome, email];
}
