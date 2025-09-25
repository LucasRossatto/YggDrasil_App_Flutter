import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/Usuario_model.dart';

class HomeHeader extends StatelessWidget {
  final String usuario;
  const HomeHeader({super.key, required this.usuario});

  String getInicialNome(String? nome) {
    if (nome == null || nome.isEmpty) return "";
    return nome[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final String inicial = getInicialNome(usuario);
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox(height: 48, width: 48, child: Text(inicial)),
              ),
              Column(
                children: [
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Email@emmail",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
