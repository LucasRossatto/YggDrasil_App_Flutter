import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/gradient_appbar.dart';
import 'package:yggdrasil_app/src/view/screens/transferir_screen.dart';
import 'package:yggdrasil_app/src/view/widgets/qr_code.dart';

class CarteiraScreen extends StatelessWidget {
  final WalletModel carteira;
  const CarteiraScreen({super.key, required this.carteira});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth * 0.7;
    final cardHeight = 180.0;
    final iconSize = 36.0;

    return Scaffold(
      appBar: GradientAppBar(title: "Carteira"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cards de moedas
              SizedBox(
                height: cardHeight,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildWalletCard(
                      colorStart: Colors.greenAccent.shade400,
                      colorEnd: Colors.green.shade700,
                      name: 'YGG',
                      subtitle: 'Yggdrasil Coin',
                      iconPath: 'assets/Icons/Icone_YGG.svg',
                      amount: '${carteira.yggCoin} YGG',
                      width: cardWidth,
                      height: cardHeight,
                      iconSize: iconSize,
                    ),
                    const SizedBox(width: 16),
                    _buildWalletCard(
                      colorStart: Colors.lightGreenAccent,
                      colorEnd: Colors.green.shade900,
                      name: 'SCC',
                      subtitle: 'SCC Token',
                      iconPath: 'assets/Icons/Icone_SCC.svg',
                      amount: '${carteira.scc} SCC',
                      width: cardWidth,
                      height: cardHeight,
                      iconSize: iconSize,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Botões de ação
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      'Transferir',
                      Colors.green,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                TransferScreen(carteira: carteira),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionButton(
                      'Receber',
                      Colors.blue,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: theme.colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "QR Code da sua carteira YggDrasil",
                                  style: TextStyle(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                WalletQrCode(walletKey: carteira.key),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                  ),
                                  child: const Text("Fechar"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // FAQ / Tutorial
              Text(
                "Como funciona a sua carteira",
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildFaqTile(
                theme: theme,
                question: "Como eu ganho moedas?",
                answer:
                    "Tokenizando uma árvore, e a partir disso, o você passa a possuir um ativo que gera SCC's ou (Save Credit Carbon), os quais o usuário tem a liberdade de vender",
              ),
              _buildFaqTile(
                theme: theme,
                question: "Como sacar minhas moedas?",
                answer:
                    "Para sacar as moedas você deve acessar o painel do YggDrasil e lá podera coletar seus YggCoins e SCC's",
              ),
              _buildFaqTile(
                theme: theme,

                question: "Como enviar moedas?",
                answer:
                    "Clique no botão 'Transferir', selecione a moeda e insira o endereço do destinatário junto com o valor.",
              ),
              _buildFaqTile(
                theme: theme,

                question: "O que são YGG e SCC?",
                answer:
                    "YGG é a moeda principal da plataforma Yggdrasil, enquanto SCC é uma moeda que equile a 1 KG de CO2 liberado por uma árvore tageada",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard({
    required Color colorStart,
    required Color colorEnd,
    required String name,
    required String subtitle,
    required String iconPath,
    required String amount,
    String? approx,
    required double width,
    required double height,
    required double iconSize,
  }) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [colorStart, colorEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // SVG de fundo como marca d'água
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.15,
              child: SvgPicture.asset(
                iconPath,
                width: 80,
                height: 80,
                color: Colors.white,
              ),
            ),
          ),
          // Conteúdo do card
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(iconPath, width: iconSize, height: iconSize),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    approx ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    Color color, {
    Color textColor = Colors.white,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onPressed ?? () {},
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

Widget _buildFaqTile({
  required String question,
  required String answer,
  required ThemeData theme,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    color: theme.colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: theme.colorScheme.outline,
        width: 1.2,
      ),
    ),
    child: ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      collapsedIconColor: theme.colorScheme.onSurfaceVariant,
      iconColor: theme.colorScheme.primary,
      title: Text(
        question,
        style: TextStyle(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            answer,
            style: TextStyle(color: theme.colorScheme.secondary),
          ),
        ),
      ],
    ),
  );
}
