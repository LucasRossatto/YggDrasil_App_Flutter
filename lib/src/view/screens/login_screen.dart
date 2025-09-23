import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/manter_contectado_checkbox.dart';
import 'package:yggdrasil_app/src/shared/widgets/password_field.dart';
import 'package:yggdrasil_app/src/viewmodel/usuario_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsuarioViewModel(),
      child: screen(
        formKey: _formKey,
        emailController: _emailController,
        emailRegex: _emailRegex,
        passwordController: _passwordController,
        isLoading: _isLoading,
      ),
    );
  }
}

class screen extends StatelessWidget {
  const screen({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required RegExp emailRegex,
    required TextEditingController passwordController,
    required bool isLoading,
  }) : _formKey = formKey,
       _emailController = emailController,
       _emailRegex = emailRegex,
       _passwordController = passwordController,
       _isLoading = isLoading;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final RegExp _emailRegex;
  final TextEditingController _passwordController;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UsuarioViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Theme.of(context).colorScheme.surface),
          BlurGradient1(),
          BlurGradient2(),

          // Conteúdo da tela
          Padding(
            padding: const EdgeInsets.all(24.0),
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
                  SizedBox(height: 20),

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
                            SizedBox(height: 20),

                            Text(
                              "Bem vindo de volta",
                              style: TextStyle(
                                fontSize: 26,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),

                            Text(
                              "Entre para explorar nosso aplicativo",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            SizedBox(height: 20),

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
                            SizedBox(height: 20),

                            PasswordField(
                              controller: _passwordController,
                              label: "Digite sua senha",
                              extraLabel: "Senha",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Informe sua senha";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            ManterContectadoCheckbox(),
                            SizedBox(height: 12),
                            LoginButton(
                              isLoading: _isLoading,
                              onPressed: () {
                                vm.login("teste@gmail.com", "123456");
                              },
                            ),

                            SizedBox(height: 20),

                            Row(
                              children: [
                                Text("Ainda não possui uma conta?"),
                                TextButton(
                                  onPressed: () {},
                                  child: Text("Criar conta"),
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
      right: 0,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
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
        imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
        child: Container(
          width: 200,
          height: 200,
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

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButton({
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
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.surface,
                    ),
                  ),
                )
              : Text(
                  "Entrar",
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
