import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/screens/adicionar_arvore_screen.dart';
import 'package:yggdrasil_app/src/view/screens/detalhe_arvore_screen.dart';
import 'package:yggdrasil_app/src/view/screens/transferir_screen.dart';
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
                  NavigationCard(
                    theme: theme,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              AdicionarArvoreScreen(usuarioId: usuario.id),
                        ),
                      );
                    },
                    iconData: Icons.add,
                    label: 'Adicionar Tag',
                  ),
                  NavigationCard(
                    theme: theme,
                    onTap: () {},
                    svgAsset: 'assets/icons/Icone_carbono.svg',
                    label: 'Registrar Emissão',
                  ),
                  NavigationCard(
                    theme: theme,
                    onTap: () async {
                      final tagId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ScannerScreen(),
                        ),
                      );

                      if (tagId == null) return;

                      try {
                        final arvore = await arvoreVm.getArvoreByQrCode(tagId);

                        if (arvore == null) {
                          if (context.mounted) {
                            CustomSnackBar.show(
                              context,
                              message:
                                  "Nenhuma árvore encontrada para a tag $tagId",
                              icon: Icons.error,
                              backgroundColor: theme.colorScheme.errorContainer,
                            );
                          }
                          return; // não navega
                        }

                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalheArvoreScreen(
                                arvore: arvore,
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
                    iconData: Icons.search_rounded,
                    label: 'Ler tag de Árvore',
                  ),
                  NavigationCard(
                    theme: theme,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              TransferScreen(carteira: wallet),
                        ),
                      );
                    },
                    svgAsset: 'assets/icons/Transação_YCC.svg',
                    label: 'Receber/Transferir',
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

class NavigationCard extends StatelessWidget {
  const NavigationCard({
    super.key,
    required this.theme,
    required this.onTap,
    this.iconData,
    this.svgAsset,
    required this.label,
  }) : assert(
         iconData != null || svgAsset != null,
         'Você precisa passar um IconData ou um caminho de SVG',
       );

  final ThemeData theme;
  final VoidCallback onTap;
  final IconData? iconData;
  final String? svgAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = screenWidth * 0.21; // 20% da largura da tela

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: cardSize,
        height: cardSize,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          padding: EdgeInsets.all(cardSize * 0.15), // padding proporcional
          child: Column(
            spacing: 3,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: cardSize * 0.3,
                  color: theme.colorScheme.onSurface,
                )
              else if (svgAsset != null)
                SvgPicture.asset(
                  svgAsset!,
                  width: cardSize * 0.3,
                  height: cardSize * 0.3,
                  // ignore: deprecated_member_use
                  color: theme.colorScheme.onSurface,
                ),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: cardSize * 0.12,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
