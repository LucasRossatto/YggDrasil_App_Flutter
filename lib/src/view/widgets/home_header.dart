import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/screens/adicionar_arvore_screen.dart';
import 'package:yggdrasil_app/src/view/screens/detalhe_arvore_screen.dart';
import 'package:yggdrasil_app/src/view/screens/emdesenvolvimento_screen.dart';
import 'package:yggdrasil_app/src/view/screens/transferir_screen.dart';
import 'package:yggdrasil_app/src/view/widgets/navigationcard_icon.dart';
import 'package:yggdrasil_app/src/view/widgets/navigationcard_svg.dart';
import 'package:yggdrasil_app/src/view/widgets/scanner_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/arvore_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  final String nome;
  final String email;
  final UsuarioModel usuario;
  final WalletModel wallet;
  final ThemeData theme;
  const HomeHeader({
    super.key,
    required this.nome,
    required this.email,
    required this.theme,
    required this.wallet,
    required this.usuario,
  });

  String getInicialNome(String? nome) {
    if (nome == null || nome.isEmpty) return "";
    return nome[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final String inicial = getInicialNome(nome);
    final arvoreVm = context.read<ArvoreViewModel>();
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(0, 166, 62, 1),
              Color.fromRGBO(0, 122, 85, 1),
            ],
            stops: [0, 0.5],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryFixedVariant,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          inicial,
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.colorScheme.onInverseSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nome,
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavigationCardIcon(
                    theme: theme,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              AdicionarArvoreScreen(usuarioId: usuario.id),
                        ),
                      );
                    },
                    icon: Icons.add,
                    label: 'Adicionar Tag',
                  ),
                  NavigationCardSvg(
                    theme: theme,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => EmDesenvolvimentoScreen(),
                      ),
                    ),
                    svgAsset: 'assets/Icons/Icone_carbono.svg',
                    label: 'Registrar Emissão',
                  ),
                  NavigationCardIcon(
                    theme: theme,
                    onTap: () async {
                      final qrCode = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ScannerScreen(),
                        ),
                      );

                      if (qrCode == null) return;

                      try {
                        final arvore = await arvoreVm.getArvoreByQrCode(qrCode);

                        if (arvore == null) {
                          if (context.mounted) {
                            CustomSnackBar.show(
                              context,
                              message:
                                  "Nenhuma árvore encontrada para a tag $qrCode",
                              icon: Icons.error,
                              backgroundColor: theme.colorScheme.errorContainer,
                            );
                          }
                          return; // não navega
                        } else {
                          if (context.mounted) {
                            CustomSnackBar.show(
                              context,
                              message: "Árvore encontrada com sucesso",
                            );
                          }
                        }

                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalheArvoreScreen(
                                arvore: arvore,
                                usuarioId: usuario.id,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          CustomSnackBar.show(
                            context,
                            message: "Erro ao buscar árvore: $e",
                            icon: Icons.error,
                            backgroundColor: theme.colorScheme.errorContainer,
                          );
                        }
                      }
                    },
                    icon: Icons.search_rounded,
                    label: 'Ler tag de Árvore',
                  ),
                  NavigationCardSvg(
                    theme: theme,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              TransferScreen(carteira: wallet),
                        ),
                      );
                    },
                    svgAsset: 'assets/Icons/Transacao_YCC.svg',
                    label: 'Transferir',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
