import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/view/screens/transferir_screen.dart';

class HomeHeader extends StatelessWidget {
  final String nome;
  final String email;
  final ThemeData theme;
  const HomeHeader({
    super.key,
    required this.nome,
    required this.email,
    required this.theme,
  });

  String getInicialNome(String? nome) {
    if (nome == null || nome.isEmpty) return "";
    return nome[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final String inicial = getInicialNome(nome);
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
                            color: theme.colorScheme.onInverseSurface,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavigationCard(
                    theme: theme,
                    onTap: () {},
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
                    onTap: () {},
                    iconData: Icons.search_rounded,
                    label: 'Ler tag de Árvore',
                  ),
                  NavigationCard(
                    theme: theme,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => TransferScreen(
                            carteira: WalletModel(
                              id: 1,
                              usuarioId: 101,
                              key: "mocked-key-123",
                              yggCoin: 500,
                              scc: 250,
                              status: 1, // exemplo: 1 = ativo, 0 = inativo
                            ),
                          ),
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
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 90,
        height: 90,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (iconData != null)
                Icon(iconData, size: 22, color: theme.colorScheme.onSurface)
              else if (svgAsset != null)
                SvgPicture.asset(
                  svgAsset!,
                  width: 22,
                  height: 22,
                  // ignore: deprecated_member_use
                  color: theme.colorScheme.onSurface,
                ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
