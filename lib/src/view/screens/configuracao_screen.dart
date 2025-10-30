import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:YggDrasil/src/blocs/auth/auth_bloc.dart';
import 'package:YggDrasil/src/blocs/auth/auth_event.dart';
import 'package:YggDrasil/src/blocs/auth/auth_state.dart';
import 'package:YggDrasil/src/blocs/configuracoes/configuracoes_bloc.dart';
import 'package:YggDrasil/src/blocs/configuracoes/configuracoes_event.dart';
import 'package:YggDrasil/src/blocs/configuracoes/configuracoes_state.dart';
import 'package:YggDrasil/src/shared/widgets/gradient_appbar.dart';
import 'package:YggDrasil/src/view/screens/startup_screen.dart';
import 'package:YggDrasil/src/view/widgets/transferir_button.dart';
import 'package:YggDrasil/src/view/widgets/termos_politica.dart';

class ConfiguracaoScreen extends StatelessWidget {
  const ConfiguracaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // === ALERTA DE LOGOUT ===
    Future<void> requestLogout() async {
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
                  "Você precisará fazer login novamente para acessar sua conta.",
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

    // === ALERTA DE EXCLUSÃO DE CONTA ===
    Future<void> requestDeleteAccount() async {
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
                  'assets/images/mascote-on-error.png',
                  height: size.height * 0.12,
                ),
                const SizedBox(height: 20),
                Text(
                  "Tem certeza que deseja excluir sua conta?",
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Essa ação é permanente e todos os seus dados serão removidos. Não será possível recuperá-los depois.",
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
                  context.read<AuthBloc>().add(DeleteAccountRequested());
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(colors.error),
                ),
                child: Text(
                  "Excluir Conta",
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
      child: SafeArea(
        child: Scaffold(
          appBar: GradientAppBar(
            title: "Configurações",
            leading: IconButton(
              icon: const Icon(Icons.close),
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
                      SeletorTema(theme: theme),
                      Text(
                        "Termos & Condições",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ListTile(
                        leading: const Icon(Icons.article),
                        title: const Text("Termos de Uso"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TermosECondicoes(),
                          ),
                        ),
                      ),
                      Hr(theme: theme),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text("Política de Privacidade"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PoliticaPrivacidadeScreen(),
                          ),
                        ),
                      ),
                      Hr(theme: theme),
                    ],
                  ),
                ),

                // === BOTÕES DE AÇÃO ===
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.03, top: 8),
                  child: Column(
                    children: [
                      TransferirButton(
                        onPressed: requestLogout,
                        text: "Sair da Conta",
                      ),
                      const SizedBox(height: 12),
                      TransferirButton(
                        onPressed: requestDeleteAccount,
                          colorProfile: ButtonColorProfile.error,
                        text: "Excluir Conta",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Hr extends StatelessWidget {
  const Hr({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(color: theme.colorScheme.outline),
    );
  }
}

class SeletorTema extends StatelessWidget {
  const SeletorTema({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfiguracoesBloc, ConfiguracoesState>(
      builder: (context, state) {
        final colors = theme.colorScheme;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tema do aplicativo",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.outline),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<AppTema>(
                  value: state.tema,
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: colors.onSurfaceVariant),
                  style: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurface),
                  items: const [
                    DropdownMenuItem(
                      value: AppTema.claro,
                      child: Row(
                        children: [
                          Icon(Icons.light_mode_outlined, color: Colors.amber),
                          SizedBox(width: 8),
                          Text("Tema Claro"),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: AppTema.escuro,
                      child: Row(
                        children: [
                          Icon(Icons.dark_mode_outlined, color: Colors.blueGrey),
                          SizedBox(width: 8),
                          Text("Tema Escuro"),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: AppTema.sistema,
                      child: Row(
                        children: [
                          Icon(Icons.computer_outlined, color: Colors.grey),
                          SizedBox(width: 8),
                          Text("Sistema"),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (AppTema? novoTema) {
                    if (novoTema == null) return;
                    ThemeMode modo;
                    switch (novoTema) {
                      case AppTema.claro:
                        modo = ThemeMode.light;
                        break;
                      case AppTema.escuro:
                        modo = ThemeMode.dark;
                        break;
                      case AppTema.sistema:
                      default:
                        modo = ThemeMode.system;
                        break;
                    }
                    context.read<ConfiguracoesBloc>().add(AlternarModoEscuro(modo));
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: colors.outlineVariant,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
          ],
        );
      },
    );
  }
}
