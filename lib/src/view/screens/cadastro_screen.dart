import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/password_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/screens/login_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/usuario_viewmodel.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  final bool _isLoading = false;
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  @override
  Widget build(BuildContext context) {
    final vm = UsuarioViewModel();

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Theme.of(context).colorScheme.surface),
          BlurGradient1(),
          BlurGradient2(),

          Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 39,
                        width: 39,
                        child: Image.asset('assets/images/logo-yggdrasil.png'),
                      ),
                      Text(
                        "YggDrasil",
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 24),

                            Text(
                              "Bem vindo de volta",
                              style: TextStyle(
                                fontSize: 26,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),

                            Text(
                              "Entre para explorar nosso aplicativo",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AppTextField(
                                    controller: _nomeController,
                                    extraLabel: 'Nome',
                                    label: 'Digite seu nome',
                                  ),
                                ),
                                Expanded(
                                  child: AppTextField(
                                    controller: _sobrenomeController,
                                    extraLabel: 'Sobrenome',
                                    label: 'Digite seu sobrenome',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),

                            AppTextField(
                              controller: _emailController,
                              extraLabel: "Email",
                              label: "Digite seu email",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Informe um email";
                                }
                                if (!_emailRegex.hasMatch(value)) {
                                  return "Endereço de e-mail não é válido";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24),

                            PasswordField(
                              controller: _senhaController,
                              label: "Digite sua senha",
                              extraLabel: "Senha",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Informe sua senha";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24),
                            PasswordField(
                              controller: _confirmarSenhaController,
                              label: "Confirme sua senha",
                              extraLabel: "Confirmar Senha",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Confirme sua senha";
                                } else if (value != _senhaController.text) {
                                  return 'As senhas não coincidem';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 24),
                            CadastroButton(
                              isLoading: _isLoading,
                              onPressed: () async {
                                String email = _emailController.text.trim();
                                String senha = _senhaController.text.trim();
                                String nome = _nomeController.text.trim();
                                String sobrenome = _sobrenomeController.text
                                    .trim();
                                final String nomeCompleto = "$nome $sobrenome";

                                final theme = Theme.of(
                                  context,
                                ).colorScheme;

                                try {
                                  await vm.cadastrarUsuario(
                                    nomeCompleto,
                                    email,
                                    senha,
                                  );

                                  if (!context.mounted) return;

                                  CustomSnackBar.show(
                                    context,
                                    message: "Cadastro realizado com sucesso!",
                                    icon: Icons.check,
                                    backgroundColor: theme.primaryContainer,
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginScreen(),
                                    ),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;

                                  CustomSnackBar.show(
                                    context,
                                    message: "Erro ao Criar conta: $e",
                                    icon: Icons.error_outline_outlined,
                                    backgroundColor: theme.errorContainer,
                                  );
                                }
                              },
                            ),

                            SizedBox(height: 24),

                            Row(
                              children: [
                                Text("Já possui uma conta?"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            //HomeScreen(usuario: usuario),
                                            LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text("Entrar"),
                                ),
                              ],
                            ),
                          ],
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
      top: 200,
      left: 300,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 130, sigmaY: 130),
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
      top: 0,
      left: 0,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 130, sigmaY: 130),
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Colors.transparent,
              ],
              radius: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}

class CadastroButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const CadastroButton({
    super.key,
    required this.onPressed,
    this.isLoading = false, // padrão false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: isLoading ? null : onPressed, // desabilita enquanto carrega
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isLoading
              ? SizedBox(
                  height: 17,
                  width: 17,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.surface,
                    ),
                  ),
                )
              : Text(
                  "Criar conta",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
        ),
      ),
    );
  }
}
