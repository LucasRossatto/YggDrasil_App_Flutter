import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/view/widgets/adicionar_arvore_form.dart';
import 'package:yggdrasil_app/src/view/widgets/scanner_screen.dart';

class AdicionarArvoreScreen extends StatefulWidget {
  final int usuarioId;

  const AdicionarArvoreScreen({super.key, required this.usuarioId});

  @override
  State<AdicionarArvoreScreen> createState() => _AdicionarArvoreScreen();
}

class _AdicionarArvoreScreen extends State<AdicionarArvoreScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usuarioId = widget.usuarioId;

    final TextEditingController tagArvore = TextEditingController();

    void abrirScanner() async {
      final result = await Navigator.of(
        context,
      ).push<String>(MaterialPageRoute(builder: (_) => const ScannerScreen()));
      if (result != null && result.isNotEmpty) {
        tagArvore.text = result; //  Atualiza o campo diretamente
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Árvore")),

      body: Column(
        children: [
          ArvoreCreateForm(
            tagIdController: tagArvore,
            arvore: ArvoreModel(
              usuarioId: usuarioId,
              tagId: 0,
              imagemURL: '',
              nome: '',
              familia: '',
              idadeAproximada: '',
              localizacao: '',
              nota: 0,
              tipo: 0,
            ),
            onSubmit: (arvore) {
              // Lógica para salvar a árvore
            },
            abrirScanner: abrirScanner,
          ),
        ],
      ),
    );
  }
}
