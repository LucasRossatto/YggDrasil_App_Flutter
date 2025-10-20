import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_event.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_bloc.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_event.dart';
import 'package:yggdrasil_app/src/blocs/configuracoes/configuracoes_state.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_bloc.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_event.dart';
import 'package:yggdrasil_app/src/repository/configuracoes_repositorio.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';
import 'package:yggdrasil_app/src/services/secure_storage_service.dart';
import 'package:yggdrasil_app/src/states/bottomnavigation_state.dart';
import 'package:yggdrasil_app/src/storage/user_storage.dart';
import 'package:yggdrasil_app/src/view/screens/cadastro_screen.dart';
import 'package:yggdrasil_app/src/view/screens/error_screen.dart';
import 'package:yggdrasil_app/src/view/screens/home_screen.dart';
import 'package:yggdrasil_app/src/view/screens/startup_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/arvore_viewmodel.dart';
import 'package:yggdrasil_app/src/viewmodel/usuario_viewmodel.dart';
import 'package:yggdrasil_app/src/viewmodel/wallet_viewmodel.dart';
import 'src/shared/themes/theme.dart';
import 'src/shared/themes/app_typography.dart';
import 'dart:ui';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configura erro global para renderização de widgets
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorScreen(details: details);
  };
  // Configura handler global para Flutter
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // Se você tiver um handler customizado, pode chamar aqui
    ErrorScreen(details: details);
  };
  // Configura handler global para erros não capturados
  PlatformDispatcher.instance.onError = (error, stack) {
    final details = FlutterErrorDetails(exception: error, stack: stack);
    ErrorScreen(details: details);
    return true; // indica que o erro foi tratado
  };
  WidgetsFlutterBinding.ensureInitialized();
  SecureStorageService.init();
  final usuarioRepository = UsuarioRepositorio();
  final configuracoesRepositorio = ConfiguracoesRepositorio();
  final storage = UserStorage();

  final idUsuario = await storage.getUserId();
  final authBloc = AuthBloc(usuarioRepository);
  authBloc.add(AppStarted());

  final Widget initialScreen = idUsuario != null
      ? const HomeScreen()
      : const StartupScreen();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
        ChangeNotifierProvider(create: (_) => ArvoreViewModel()),
        ChangeNotifierProvider(create: (_) => WalletViewmodel()),
        ChangeNotifierProvider(create: (_) => BottomNavigationState()),
        ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(usuarioRepository)),
          BlocProvider(
            create: (_) =>
                UsuarioBloc(usuarioRepository)
                  ..add(LoadUsuario(idUsuario.toString())),
          ),
          BlocProvider(
            create: (_) =>
                ConfiguracoesBloc(configuracoesRepositorio)
                  ..add(CarregarConfiguracoes()),
          ),
        ],
        child: MyApp(initialScreen: initialScreen),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Poppins", "Poppins");
    final materialTheme = MaterialTheme(textTheme);

    return BlocBuilder<ConfiguracoesBloc, ConfiguracoesState>(
      builder: (context, state) {
        ThemeMode currentMode;
        switch (state.tema) {
          case AppTema.claro:
            currentMode = ThemeMode.light;
            break;
          case AppTema.escuro:
            currentMode = ThemeMode.dark;
            break;
          case AppTema.sistema:
          default:
            currentMode = ThemeMode.system;
        }

        return MaterialApp(
          title: 'YggDrasil Alpha 0.1.0',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          home: initialScreen,
        );
      },
    );
  }
}
