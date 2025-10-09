import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_event.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_bloc.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_event.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';
import 'package:yggdrasil_app/src/states/bottomnavigation_state.dart';
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
    // myErrorsHandler.onErrorDetails(details);
  };
  // Configura handler global para erros não capturados
  PlatformDispatcher.instance.onError = (error, stack) {
    // myErrorsHandler.onError(error, stack);
    return true; // indica que o erro foi tratado
  };

  WidgetsFlutterBinding.ensureInitialized();

  final usuarioRepository = UsuarioRepositorio();
  final prefs = await SharedPreferences.getInstance();
  final idUsuario = prefs.getInt('usuario_id'); 
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
        ChangeNotifierProvider(
          create: (_) => BottomNavigationState(),
        ), // controller
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(usuarioRepository)),
          BlocProvider(
            create: (_) => UsuarioBloc(usuarioRepository)..add(LoadUsuario(idUsuario.toString())),
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
    final TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'YggDrasil Alpha 0.1.0',
      themeMode: ThemeMode.system,
      theme: theme.light(),
      darkTheme: theme.dark(),
      home: initialScreen,
    );
  }
}
