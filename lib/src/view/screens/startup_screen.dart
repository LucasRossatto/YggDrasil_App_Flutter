import 'package:flutter/material.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(style: TextStyle(fontSize: 38.0), 'Bem vindo ao'),
                Text(
                  style: TextStyle(
                    fontSize: 38.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  "YggDrasil",
                ),
              ],
            ),
            Text("Monitore a vida e se junte a revolução verde"),
            Image(image: AssetImage('assets/images/logo-yggdrasil.png')),
            ElevatedButton(onPressed: () {}, child: Text("Criar Conta")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text('Já tem uma conta?'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    "Entrar",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
