import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/view/screens/mascote_detalhes_screen.dart';

class MascoteIntroModal extends StatefulWidget {
  const MascoteIntroModal({super.key});

  @override
  State<MascoteIntroModal> createState() => _MascotIntroModalState();

  /// Abre o modal em tela cheia
  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Mascot Intro',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const MascoteIntroModal(),
      transitionBuilder: (_, anim, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }
}

class _MascotIntroModalState extends State<MascoteIntroModal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Route _createSlideRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const MascoteDetalhesScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  Widget _animatedBlob({
    required Color color,
    required Offset offset,
    required double delay,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = (_controller.value + delay).clamp(0.0, 1.0).toDouble();
        final dx = offset.dx * (0.5 - (progress - 0.5).abs() * 2);
        final dy = offset.dy * (0.5 - (progress - 0.5).abs() * 2);
        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.scale(
            scale: 1 + 0.1 * (0.5 - (progress - 0.5).abs()) * 2,
            child: child,
          ),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: color.withAlpha((0.7 * 255).toInt()),
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: GestureDetector(
        // Detecta o arrasto horizontal
        onHorizontalDragEnd: (details) {
          // Se arrastar da direita para a esquerda (velocidade negativa)
          if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
            Navigator.of(context).push(_createSlideRoute());
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: theme.colorScheme.onSurfaceVariant,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Conteúdo principal
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // blobs animados
                        Positioned(
                          top: -60,
                          left: -60,
                          child: _animatedBlob(
                            color: Colors.lightGreenAccent.shade400,
                            offset: const Offset(30, -50),
                            delay: 0,
                          ),
                        ),
                        Positioned(
                          bottom: -60,
                          right: -60,
                          child: _animatedBlob(
                            color: Colors.green.shade500,
                            offset: const Offset(-20, 20),
                            delay: 0.3,
                          ),
                        ),
                        Positioned(
                          bottom: -60,
                          left: 20,
                          child: _animatedBlob(
                            color: Colors.lightGreenAccent,
                            offset: const Offset(20, -30),
                            delay: 0.6,
                          ),
                        ),
                        // imagem principal
                        Image.asset(
                          'assets/images/mascote/mascote-acenando.png',
                          width: screenWidth * 0.7,
                          height: screenWidth * 0.7,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Texto e botão
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      'Conheça o Ratatosk!',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'O mascote oficial do YggDrasil',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(_createSlideRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onSurfaceVariant,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                        ),
                        child: Text(
                          'Conhecer Ratatosk',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.surface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Footer com indicadores
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_dot(true), const SizedBox(width: 6), _dot(false)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: active
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
        shape: BoxShape.circle,
      ),
    );
  }
}
