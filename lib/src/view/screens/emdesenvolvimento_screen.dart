import 'package:flutter/material.dart';

class EmDesenvolvimentoScreen extends StatelessWidget {
  final String title;

  const EmDesenvolvimentoScreen({
    super.key,
    this.title = "Tela em Desenvolvimento",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: theme.primary,
        foregroundColor: theme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 80,
              color: theme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              "Esta tela ainda está em desenvolvimento!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Aguarde atualizações futuras.",
              style: TextStyle(
                fontSize: 14,
                color: theme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
