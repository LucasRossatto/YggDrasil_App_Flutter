import 'package:flutter/material.dart';

class MascoteDetalhesScreen extends StatelessWidget {
  const MascoteDetalhesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primary = theme.colorScheme.primary;
    final Color surface = theme.colorScheme.surface;
    final Color textColor = theme.colorScheme.onSurface;
    final Color borderColor = theme.colorScheme.outline.withAlpha(
      (0.4 * 255).toInt(),
    );
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width > 600;
    final double horizontalPadding = isTablet ? 32 : 20;
    final double verticalPadding = isTablet ? 24 : 16;

    return GestureDetector(
      // Detecta o arraste no sentido esquerdo → direito
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          // arraste para a direita
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: surface,
        body: SafeArea(
          child: Column(
            children: [
              // HEADER
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Conhecendo Ratatosk",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),

              // CONTEÚDO SCROLLÁVEL
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Quem é Ratatosk", primary),
                      Text(
                        "Ratatosk é o esquilo mensageiro da árvore Yggdrasil, a árvore do mundo na mitologia nórdica.\nEle corre incansavelmente entre os galhos e raízes, levando mensagens — e provocações — entre a águia no topo e o dragão Níðhöggr que vive nas profundezas.",
                        style: TextStyle(
                          fontSize: isTablet ? 17 : 15,
                          height: 1.6,
                          color: textColor.withAlpha((0.8 * 255).toInt()),
                        ),
                      ),
                      const SizedBox(height: 28),

                      _buildSectionTitle("Inspiração", primary),
                      _buildInfoTile(
                        context,
                        icon: Icons.public,
                        title: "A ponte entre mundos",
                        text:
                            "Representa a comunicação entre o céu e o submundo — entre sabedoria e caos. "
                            "Ele simboliza a troca constante de informação e energia.",
                        color: primary,
                        borderColor: borderColor,
                        isTablet: isTablet,
                      ),

                      _buildSectionTitle("Personalidade", primary),
                      _buildInfoTile(
                        context,
                        icon: Icons.psychology_alt_outlined,
                        title: "Curioso e provocador",
                        text:
                            "Inteligente e travesso, Ratatosk adora espalhar rumores, testar limites e observar o impacto das palavras. "
                            "Ele é ágil, falante e espirituoso.",
                        color: primary,
                        borderColor: borderColor,
                        isTablet: isTablet,
                      ),

                      _buildSectionTitle("Simbolismo", primary),
                      _buildInfoTile(
                        context,
                        icon: Icons.bubble_chart_outlined,
                        title: "Comunicação e dualidade",
                        text:
                            "Ratatosk representa a força das palavras — capazes de unir ou dividir. "
                            "Ele reflete a natureza dual da linguagem: criadora e destrutiva.",
                        color: primary,
                        borderColor: borderColor,
                        isTablet: isTablet,
                      ),

                      _buildSectionTitle("Inspiração moderna", primary),
                      _buildInfoTile(
                        context,
                        icon: Icons.wifi_tethering_outlined,
                        title: "O mensageiro digital",
                        text:
                            "Hoje, Ratatosk pode simbolizar o fluxo de informação na era digital — "
                            "as redes que conectam o mundo e o poder das mensagens que enviamos.",
                        color: primary,
                        borderColor: borderColor,
                        isTablet: isTablet,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              // FOOTER + INDICADORES
              Container(
                decoration: BoxDecoration(
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(primary, borderColor, false),
                    const SizedBox(width: 6),
                    _dot(primary, borderColor, true),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color primary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 24),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 22,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primary,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String text,
    required Color color,
    required Color borderColor,
    required bool isTablet,
  }) {
    final Color background = color.withAlpha((0.1 * 255).toInt());

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: isTablet ? 52 : 46,
            width: isTablet ? 52 : 46,
            decoration: BoxDecoration(
              color: color.withAlpha((0.15 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: isTablet ? 28 : 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 18 : 16,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha((0.8 * 255).toInt()),
                    fontSize: isTablet ? 15 : 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color primary, Color border, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: active ? 10 : 8,
      height: active ? 10 : 8,
      decoration: BoxDecoration(
        color: active ? primary : border,
        shape: BoxShape.circle,
      ),
    );
  }
}
