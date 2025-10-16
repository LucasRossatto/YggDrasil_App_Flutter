import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/states/bottomnavigation_state.dart';
import 'package:yggdrasil_app/src/view/screens/carteira_screen.dart';
import 'package:yggdrasil_app/src/view/screens/configuracao_screen.dart';
import 'package:yggdrasil_app/src/view/screens/perfil_screen.dart';

class BottomNavigation extends StatelessWidget {
  final double iconSize;
  final double svgSize;
  final WalletModel wallet;
  final UsuarioModel usuario;

  const BottomNavigation({
    super.key,
    this.iconSize = 30,
    this.svgSize = 30,
    required this.wallet, required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    final navState = context.watch<BottomNavigationState>();
        final theme = Theme.of(context);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context,
              index: 0,
              icon: Icons.home_rounded,
              label: 'Home',
              onPressed: () => navState.setIndex(0),
            ),
            _buildNavItem(
              context,
              index: 1,
              icon: (Icons.wallet_outlined),
              label: 'Carteira',
              onPressed: () => {
                navState.setIndex(1),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CarteiraScreen(carteira: wallet,)),
                ),
              },
            ),
            const SizedBox(width: 40),
            _buildNavItem(
              context,
              index: 2,
              icon: Icons.settings_outlined,
              label: 'Configurações',
              onPressed: () {
                navState.setIndex(2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConfiguracaoScreen(),
                  ),
                );
              },
            ),
            _buildNavItem(
              context,
              index: 3,
              icon: Icons.person_outline_rounded,
              label: 'Perfil',
              onPressed: () => {
                navState.setIndex(3),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PerfilScreen(usuario: usuario,)),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    IconData? icon,
    String? svgAsset,
    required String label,
    required VoidCallback onPressed,
  }) {
    final navState = context.watch<BottomNavigationState>();
    final isActive = navState.selectedIndex == index;
        final theme = Theme.of(context);

    final Color activeColor = theme.colorScheme.onInverseSurface;
    final Color inactiveColor = theme.colorScheme.surface;

    final color = isActive ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, size: iconSize, color: color)
          else if (svgAsset != null)
            SvgPicture.asset(
              svgAsset,
              width: svgSize,
              height: svgSize,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
