import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/widgets/home_header.dart';
import 'package:yggdrasil_app/src/view/widgets/overview_container.dart';

class HomeScreen extends StatelessWidget {
  final UsuarioModel usuario;

  const HomeScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usuarioState = context.watch<UsuarioState>();
    final wallet = usuarioState.wallet;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeader(nome: usuario.nome, email: usuario.email, theme: theme),
            OverviewContainer(theme: theme, wallet: wallet),
          ],
        ),
      ),
    );
  }
}
