import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_event.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_state.dart';
import 'package:yggdrasil_app/src/shared/widgets/gradient_appbar.dart';
import 'package:yggdrasil_app/src/view/screens/startup_screen.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';

class ConfiguracaoScreen extends StatelessWidget {
  const ConfiguracaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navegação segura, sem possibilidade de voltar
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const StartupScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: GradientAppBar(
          title: "Configurações",
          leading: IconButton(
            icon: Icon(Icons.close),
            color: theme.colorScheme.surface,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(),
              TransferirButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoggedOut());
                },
                text: "Sair da Conta",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
