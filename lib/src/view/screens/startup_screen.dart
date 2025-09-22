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
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Bem vindo ao'), Text("YggDrasil")],
            ),
            Text("Monitore a vida e se junte a revolução verde"),
            Image(image: AssetImage('assets/images/logo-yggdrasil.png')),
            ElevatedButton(onPressed: () {}, child: Text("Criar Conta")),
            Row(
                        mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text('Já tem uma conta?'),
                TextButton(onPressed: () {}, child: Text("Entrar")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
