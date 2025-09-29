import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/screens/startup_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/arvore_viewmodel.dart';
import 'package:yggdrasil_app/src/viewmodel/usuario_viewmodel.dart';
import 'src/shared/themes/theme.dart';
import 'src/shared/themes/app_typography.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // carrega dotenv
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Erro ao carregar .env: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioState()),
        ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
        ChangeNotifierProvider(create: (_) => ArvoreViewModel()),
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
