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

    @override
    void dispose() {
      carteiraDestino.dispose();
      super.dispose();
    }

    void abrirScanner() async {
      final result = await Navigator.of(
        context,
      ).push<String>(MaterialPageRoute(builder: (_) => const ScannerScreen()));
      if (result != null) {
        setState(() {
          carteiraDestino.text = result; // preenche automaticamente
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Transferir")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToggleButtons(
            isSelected: [_selectedType == 0, _selectedType == 1],
            onPressed: (index) {
              setState(() {
                _selectedType = index;
              });
            },

            borderRadius: BorderRadius.circular(18),
            borderColor: theme.colorScheme.outline,
            selectedBorderColor: theme.colorScheme.surfaceTint,
            selectedColor: theme.colorScheme.surface,
            fillColor: theme.colorScheme.surfaceTint,
            color: theme.colorScheme.outline,
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

          const SizedBox(height: 20),

          // Conteúdo condicional
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _selectedType == 0
                  ? YggTransferirForm(
                      key: const ValueKey('YGGForm'),
                      carteiraId: carteiraUsuario.id,
                      carteiraSaldo: carteiraUsuario.yggCoin,
                      abrirScanner: abrirScanner,
                    )
                  : SccTransferirForm(
                      key: const ValueKey('SCCForm'),
                      carteiraId: carteiraUsuario.id,
                      carteiraSaldo: carteiraUsuario.scc,
                      abrirScanner: abrirScanner,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
