import 'dart:ui';

import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails details;
  const ErrorScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          BlurGradient1(),
          BlurGradient2(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Imagem de erro
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/images/mascote-on-error.png', // Coloque sua imagem aqui
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Título
                  Text(
                    'Oops!',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtexto
                  Text(
                    'Ocorreu um erro inesperado:\n${details.exceptionAsString()}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Botão para voltar
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Toque para voltar a tela inicial',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlurGradient2 extends StatelessWidget {
  const BlurGradient2({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 300,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Colors.transparent,
              ],
              radius: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class BlurGradient1 extends StatelessWidget {
  const BlurGradient1({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 300,
      left: 0,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Colors.transparent,
              ],
              radius: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
