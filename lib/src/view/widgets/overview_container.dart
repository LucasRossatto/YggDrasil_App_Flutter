import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:YggDrasil/src/models/wallet_model.dart';

class OverviewContainer extends StatelessWidget {
  final ThemeData theme;
  final WalletModel wallet;
  final int qtdeTagsTotal;
  const OverviewContainer({
    super.key,
    required this.theme,
    required this.wallet,
    required this.qtdeTagsTotal,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.025,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                theme: theme,
                svgAsset: 'assets/Icons/Icone_SCC.svg',
                onTap: () {},
                label: "SCC Valhalla",
                value: wallet.scc.toString(),
                valueColor: theme.colorScheme.primary,
              ),
              Card(
                theme: theme,
                svgAsset: 'assets/Icons/Icone_arvores.svg',
                onTap: () {},
                label: "Árvores tags",
                value: qtdeTagsTotal.toString(),
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
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                spacing: screenWidth * 0.19,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: screenWidth * 0.02,
                    children: [
                      SvgPicture.asset(
                        'assets/Icons/Icone_YGG.svg',
                        width: screenWidth * 0.09,
                        height: screenWidth * 0.09,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "YGG",
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Text(
                            wallet.yggCoin.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    width: 1,
                    height: screenWidth * 0.12,
                    color: theme.colorScheme.outline,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      SvgPicture.asset(
                        'assets/Icons/Icone_SCC.svg',
                        width: screenWidth * 0.09,
                        height: screenWidth * 0.09,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SCC",
                            style: TextStyle(fontSize: screenWidth * 0.045),
                          ),
                          Text(
                            wallet.scc.toString(),
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: screenWidth * 0.04,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth * 0.29,
        height: height * 0.145,
        child: AspectRatio(
          aspectRatio: 1.05,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(color: theme.colorScheme.outline),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (iconData != null)
                  Icon(iconData, size: screenWidth * 0.07, color: valueColor)
                else if (svgAsset != null)
                  SvgPicture.asset(
                    svgAsset!,
                    width: screenWidth * 0.07,
                    height: screenWidth * 0.07,
                    // ignore: deprecated_member_use
                  ),
                SizedBox(height: height * 0.02),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
