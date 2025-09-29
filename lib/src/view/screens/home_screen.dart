import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/widgets/home_header.dart';
import 'package:yggdrasil_app/src/view/widgets/overview_container.dart';
import 'package:yggdrasil_app/src/view/widgets/qr_code.dart';

class HomeScreen extends StatelessWidget {
  final UsuarioModel usuario;
  final WalletModel wallet;

  const HomeScreen({super.key, required this.usuario, required this.wallet});
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
            child: Icon(
              Icons.qr_code_rounded,
              color: theme.colorScheme.surface,
              size: 37,
            ),
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
                  // ignore: deprecated_member_use
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
            HomeHeader(
              nome: usuario.nome,
              email: usuario.email,
              theme: theme,
              wallet: wallet,
              usuario: usuario,
            ),
            OverviewContainer(theme: theme, wallet: wallet),
          ],
        ),
      ),
    );
  }
}
