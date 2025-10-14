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
    Future<void> request() async {
      await showDialog<bool>(
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          final colors = theme.colorScheme;
          final textTheme = theme.textTheme;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/mascote/mascote-logout.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  "Deseja realmente sair da conta?",
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Você terá que fazer login novamente para acessar sua conta.",
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancelar",
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(LoggedOut());
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(colors.error),
                ),
                child: Text(
                  "Sair da Conta",
                  style: textTheme.labelLarge?.copyWith(
                    color: colors.errorContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

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
              TransferirButton(onPressed: request, text: "Sair da Conta"),
            ],
          ),
        ),
      ),
    );
  }
}
