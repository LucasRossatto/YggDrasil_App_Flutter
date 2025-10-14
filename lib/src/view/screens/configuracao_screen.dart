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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/mascote/mascote-logout.png',
                  height: size.height * 0.12, // responsivo
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
                  backgroundColor: WidgetStatePropertyAll(colors.error),
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
                      "Geral",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text("Privacidade"),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Privacidade"),
                            content: const Text(
                              "Coletamos apenas informações necessárias para cadastrar árvores e avaliações. "
                              "Suas informações não serão compartilhadas com terceiros sem consentimento.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Fechar"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text("Sobre o App"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Sobre o App"),
                            content: Text(
                              "Yggdrasil App\n"
                              "Versão 1.0.0\n\n"
                              "Este aplicativo permite cadastrar árvores, registrar avaliações e acompanhar informações de forma prática e segura.\n\n"
                              "Desenvolvido pela Advantag Tecnologia e Serviços Ltda.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Fechar"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  Container( height: 1, width: double.infinity, decoration: BoxDecoration( color: theme.colorScheme.outline, ), ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: size.height * 0.03, // padding inferior responsivo
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
