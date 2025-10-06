import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/manter_contectado_checkbox.dart';
import 'package:yggdrasil_app/src/shared/widgets/password_field.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/screens/cadastro_screen.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/screens/home_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/usuario_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsuarioViewModel(),
      child: LoginForm(
        formKey: _formKey,
        emailController: _emailController,
        emailRegex: _emailRegex,
        senhaController: _senhaController,
        isLoading: _isLoading,
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required RegExp emailRegex,
    required TextEditingController senhaController,
    required bool isLoading,
  }) : _formKey = formKey,
       _emailController = emailController,
       _emailRegex = emailRegex,
       _senhaController = senhaController,
       _isLoading = isLoading;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final RegExp _emailRegex;
  final TextEditingController _senhaController;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UsuarioViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  SizedBox(height: 24),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
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

                            AppTextField(
                              controller: _emailController,
                              extraLabel: "Email",
                              keyboardType: TextInputType.emailAddress,
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
                            SizedBox(height: 10),
                            ManterContectadoCheckbox(),
                            SizedBox(height: 24),

                            LoginButton(
                              isLoading: vm.isLoading,
                              onPressed: () async {
                                final email = _emailController.text.trim();
                                final senha = _senhaController.text.trim();
                                final theme = Theme.of(context).colorScheme;

                                try {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  final idUsuario = await vm.login(
                                    email,
                                    senha,
                                  );

                                  if (!context.mounted) return;

                                  if (idUsuario == null) {
                                    CustomSnackBar.show(
                                      context,
                                      message: "Nome e email incorretos",
                                      profile: 'error',
                                    );
                                    return;
                                  }

                                  final res = await vm.getInformacoesUsuario(
                                    idUsuario.toString(),
                                  );

                                  if (!context.mounted) return;

                                  if (res != null) {
                                    context.read<UsuarioState>().setUsuario(
                                      UsuarioModel(
                                        id: res.usuario.id,
                                        nome: res.usuario.nome,
                                        email: res.usuario.email,
                                      ),
                                      WalletModel(
                                        id: res.wallet.id,
                                        usuarioId: res.wallet.usuarioId,
                                        key: res.wallet.key,
                                        yggCoin: res.wallet.yggCoin,
                                        scc: res.wallet.scc,
                                        status: res.wallet.status,
                                      ),
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => HomeScreen(
                                            usuario: res.usuario,
                                            wallet: res.wallet,
                                            qtdeTagsTotal: res.qtdeTagsTotal,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Usuário ou senha inválidos",
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (!context.mounted) return;
                                  CustomSnackBar.show(
                                    context,
                                    message: "Nome e email incorretos",
                                    profile: 'error',
                                  );
                                }
                              },
                            ),

                            SizedBox(height: 24),

                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: [
                                Text(
                                  "Ainda não possui uma conta?",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 600
                                        ? 14
                                        : 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.8),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CadastroScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Criar conta",
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                              600
                                          ? 14
                                          : 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
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
        onPressed: isLoading ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
