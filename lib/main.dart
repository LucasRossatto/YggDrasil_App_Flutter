import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/states/usuario_state.dart';
import 'package:yggdrasil_app/src/view/screens/home_screen.dart';
import 'src/shared/themes/theme.dart';
import 'src/shared/themes/app_typography.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // carrega dotenv
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UsuarioState())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    final usuarioMock = UsuarioModel(
      id: 1,
      nome: "Lucas Rossatto",
      email: "lucas.rossatto@example.com",
    );

    final walletMock = WalletModel(
      id: 1,
      usuarioId: 101,
      key: "mocked-key-123",
      yggCoin: 500,
      scc: 250,
      status: 1, // exemplo: 1 = ativo, 0 = inativo
    );
    return MaterialApp(
      title: 'YggDrasil Demo',
      themeMode: ThemeMode.light,
      theme: theme.light(),
      darkTheme: theme.dark(),
      home: HomeScreen(usuario: usuarioMock, wallet: walletMock),
    );
  }
}
