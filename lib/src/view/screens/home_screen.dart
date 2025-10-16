import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_bloc.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_state.dart';
import 'package:yggdrasil_app/src/shared/widgets/qrcode_modal.dart';
import 'package:yggdrasil_app/src/view/widgets/bottom_navigationbar.dart';
import 'package:yggdrasil_app/src/view/widgets/home_header.dart';
import 'package:yggdrasil_app/src/view/widgets/lista_arvores.dart';
import 'package:yggdrasil_app/src/view/widgets/overview_container.dart';
import 'package:yggdrasil_app/src/view/widgets/qr_code.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void _showBottomSheet(BuildContext context, WalletModel wallet) {
    qrcodeModal(context, wallet);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<UsuarioBloc, UsuarioState>(
      builder: (context, state) {
        if (state is UsuarioLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UsuarioLoaded) {
          final usuario = state.usuario;
          final wallet = state.wallet;
          final qtdeTagsTotal = state.qtdeTagsTotal;

          return Scaffold(
            appBar: AppBar(
              title: const Text("YggDrasil Alpha 0.1.0"),
              automaticallyImplyLeading: false,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: FloatingActionButton(
                  onPressed: () => _showBottomSheet(context, wallet),
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.qr_code_rounded,
                    color: theme.colorScheme.surface,
                    size: 37,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigation(
              wallet: wallet,
              usuario: usuario,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  HomeHeader(
                    nome: usuario.nome,
                    email: usuario.email,
                    theme: theme,
                    wallet: wallet,
                    usuario: usuario,
                  ),
                  OverviewContainer(
                    theme: theme,
                    wallet: wallet,
                    qtdeTagsTotal: qtdeTagsTotal,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListaArvores(userId: usuario.id),
                  ),
                ],
              ),
            ),
          );
        } else if (state is UsuarioError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
