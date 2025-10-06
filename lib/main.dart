import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/states/bottomnavigation_state.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/screens/error_screen.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioState()),
        ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
        ChangeNotifierProvider(create: (_) => ArvoreViewModel()),
        ChangeNotifierProvider(create: (_) => WalletViewmodel()),
        ChangeNotifierProvider(create: (_) => BottomNavigationState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'YggDrasil Alpha 0.1.0',
      themeMode: ThemeMode.system,
      theme: theme.light(),
      darkTheme: theme.dark(),
      home: StartupScreen(),
    );
  }
}
