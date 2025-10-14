import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_event.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_state.dart';
import 'package:yggdrasil_app/src/shared/widgets/gradient_appbar.dart';
import 'package:yggdrasil_app/src/view/screens/startup_screen.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';
import 'package:yggdrasil_app/src/view/widgets/termos_politica.dart'; // ← import das telas

class ConfiguracaoScreen extends StatelessWidget {
  const ConfiguracaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Future<void> request() async {
      await showDialog<bool>(
        context: context,
        builder: (context) {
          final colors = theme.colorScheme;
          final textTheme = theme.textTheme;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/mascote/mascote-logout.png',
                  height: size.height * 0.12,
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
                  backgroundColor: MaterialStatePropertyAll(colors.error),
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
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  children: [
                    Text(
                      "Termos & Condições",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),                   
                    // Termos de Uso
                    ListTile(
                      leading: Icon(Icons.article),
                      title: Text("Termos de Uso"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TermosECondicoes()),
                        );
                      },
                    ),

                    // Política de Privacidade
                    ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text("Política de Privacidade"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PoliticaPrivacidadeScreen()),
                        );
                      },
                    ),

                    Container(
                      height: 1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: size.height * 0.03,
                  top: 8,
                ),
                child: TransferirButton(
                  onPressed: request,
                  text: "Sair da Conta",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
