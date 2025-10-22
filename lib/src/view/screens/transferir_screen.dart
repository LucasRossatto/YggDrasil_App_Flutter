import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/view/widgets/scanner_screen.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_scc_form.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_ygg_form.dart';

class TransferScreen extends StatefulWidget {
  final WalletModel carteira;
  const TransferScreen({super.key, required this.carteira});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  // 0 = transferência YGG, 1 = transferência SCC
  int _selectedType = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final carteiraUsuario = widget.carteira;

    final TextEditingController carteiraDestino = TextEditingController();
    final TextEditingController quantidadeYgg = TextEditingController();
    final TextEditingController quantidadeScc = TextEditingController();

    void abrirScanner() async {
      final result = await Navigator.of(
        context,
      ).push<String>(MaterialPageRoute(builder: (_) => const ScannerScreen()));
      if (result != null && result.isNotEmpty) {
        carteiraDestino.text = result; //  Atualiza o campo diretamente
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Transferir"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 166, 62, 1),
                Color.fromRGBO(0, 122, 85, 1),
              ],
              stops: [0, 0.5],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ToggleButtons(
              isSelected: [_selectedType == 0, _selectedType == 1],
              onPressed: (index) {
                setState(() {
                  _selectedType = index;
                });
              },
            
              borderRadius: BorderRadius.circular(18),
              borderColor: theme.colorScheme.secondary,
              selectedBorderColor: theme.colorScheme.surfaceTint,
              selectedColor: theme.colorScheme.surface,
              fillColor: theme.colorScheme.surfaceTint,
              color: theme.colorScheme.secondary,
              constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("YGG"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("SCC"),
                ),
              ],
            ),
          ),
          // Conteúdo condicional
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _selectedType == 0
                    ? YggTransferirForm(
                        carteiraUsuario: carteiraUsuario,
                        key: const ValueKey('YGGForm'),
                        carteiraKey: carteiraUsuario.key,
                        carteiraSaldo: carteiraUsuario.yggCoin,
                        abrirScanner: abrirScanner,
                        carteiraDestinoController: carteiraDestino,
                        quantidadeController: quantidadeYgg,
                      )
                    : SccTransferirForm(
                        carteiraUsuario: carteiraUsuario,
                        key: const ValueKey('SCCForm'),
                        carteiraKey: carteiraUsuario.id,
                        carteiraSaldo: carteiraUsuario.scc,
                        abrirScanner: abrirScanner,
                        carteiraDestinoController: carteiraDestino,
                        quantidadeController: quantidadeScc,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
