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
            Image.asset('assets/images/mascote/mascote-construindo.png'),
            const SizedBox(height: 8),
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
              "Fique ligado nas próximas atualizações!",
              style: TextStyle(fontSize: 14, color: theme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                "Voltar para tela incial",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
