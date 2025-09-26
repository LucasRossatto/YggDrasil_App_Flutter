import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final ThemeData theme = Theme.of(context);
    final usuarioState = context.watch<UsuarioState>();
    final wallet = usuarioState.wallet;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.qr_code_rounded,
            color: theme.colorScheme.onSurface,
            size: 37,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: theme.colorScheme.primary,
        child: IconTheme(
          data: IconThemeData(color: theme.colorScheme.outline),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home_rounded, size: 53),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.stacked_bar_chart_outlined, size: 53),
              ),
              Text("Qr code"),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/Icons/Transação_YCC.svg',
                  width: 54,
                  height: 54,
                  color: theme.colorScheme.secondary,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_outline_rounded, size: 53),
              ),
            ],
          ),
        ),
      ),
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
