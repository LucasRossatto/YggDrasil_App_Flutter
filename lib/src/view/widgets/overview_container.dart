import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';

class OverviewContainer extends StatelessWidget {
  final ThemeData theme;
  final WalletModel wallet;
  const OverviewContainer({
    super.key,
    required this.theme,
    required this.wallet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                theme: theme,
                svgAsset: 'assets/Icons/Icone_SCC.svg',
                onTap: () {},
                label: "SCC",
                value: wallet.scc.toString(),
                valueColor: theme.colorScheme.primary,
              ),
              Card(
                theme: theme,
                svgAsset: 'assets/Icons/Icone_arvores.svg',
                onTap: () {},
                label: "Árvores tags",
                value: '12',
                valueColor: theme.colorScheme.primary,
              ),
              Card(
                theme: theme,
                iconData: Icons.star,
                onTap: () {},
                label: "Avaliação",
                value: '5',
                valueColor: Color(0xF8FFCE2C),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: theme.colorScheme.secondary),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                spacing: 60,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      SvgPicture.asset(
                        'assets/Icons/Icone_YGG.svg',
                        width: 39,
                        height: 39,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("YGG", style: TextStyle(fontSize: 18)),
                          Text(
                            wallet.yggCoin.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    width: 1,
                    height: 50,
                    color: theme.colorScheme.secondary,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      SvgPicture.asset(
                        'assets/Icons/Icone_YGGTAGG.svg',
                        width: 37,
                        height: 23,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("YGGTags", style: TextStyle(fontSize: 18)),
                          Text(
                            wallet.yggCoin.toString(),
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.theme,
    required this.onTap,
    this.iconData,
    this.svgAsset,
    required this.value,
    required this.label,
    required this.valueColor,
  }) : assert(
         iconData != null || svgAsset != null,
         'Você precisa passar um IconData ou um caminho de SVG',
       );

  final ThemeData theme;
  final VoidCallback onTap;
  final IconData? iconData;
  final String? svgAsset;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 120,
        height: 114,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: BoxBorder.all(color: theme.colorScheme.secondary),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (iconData != null)
                Icon(iconData, size: 31, color: valueColor)
              else if (svgAsset != null)
                SvgPicture.asset(
                  svgAsset!,
                  width: 31,
                  height: 31,
                  // ignore: deprecated_member_use
                ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(value, style: TextStyle(fontSize: 20, color: valueColor)),
            ],
          ),
        ),
      ),
    );
  }
}
