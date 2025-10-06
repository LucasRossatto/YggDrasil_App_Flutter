import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/widgets/bottom_navigationbar.dart';
import 'package:yggdrasil_app/src/view/widgets/home_header.dart';
import 'package:yggdrasil_app/src/view/widgets/lista_arvores.dart';
import 'package:yggdrasil_app/src/view/widgets/overview_container.dart';
import 'package:yggdrasil_app/src/view/widgets/qr_code.dart';

class HomeScreen extends StatelessWidget {
  final UsuarioModel usuario;
  final WalletModel wallet;
  final int qtdeTagsTotal;

  const HomeScreen({
    super.key,
    required this.usuario,
    required this.wallet,
    required this.qtdeTagsTotal,
  });
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Carteira',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Este é seu código para receber Yggcoins ou SCC por Transferência",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              WalletQrCode(walletKey: wallet.key),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final usuarioState = context.watch<UsuarioState>();
    final wallet = usuarioState.wallet;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("YggDrasil Alpha 0.1.0"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: FloatingActionButton(
            onPressed: () => _showBottomSheet(context),
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ), // controla o arredondamento
            ),
            child: Icon(
              Icons.qr_code_rounded,
              color: theme.colorScheme.surface,
              size: 37,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(wallet: wallet),
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
  }
}

