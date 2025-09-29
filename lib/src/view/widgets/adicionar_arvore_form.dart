import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';

class ArvoreCreateForm extends StatefulWidget {
  final ArvoreModel arvore;
  final TextEditingController tagIdController;
  final VoidCallback abrirScanner;
  final void Function(ArvoreModel) onSubmit;

  const ArvoreCreateForm({
    super.key,
    required this.arvore,
    required this.onSubmit,
    required this.tagIdController,
    required this.abrirScanner,
  });

  @override
  State<ArvoreCreateForm> createState() => _ArvoreCreateFormState();
}

class _ArvoreCreateFormState extends State<ArvoreCreateForm> {
  late TextEditingController usuarioIdController;
  late TextEditingController imagemURLController;
  late TextEditingController nomeController;
  late TextEditingController familiaController;
  late TextEditingController idadeAproximadaController;
  late TextEditingController localizacaoController;
  late TextEditingController notaController;
  late TextEditingController tipoController;

  @override
  void initState() {
    super.initState();
    usuarioIdController = TextEditingController(
      text: widget.arvore.usuarioId.toString(),
    );
    imagemURLController = TextEditingController(text: widget.arvore.imagemURL);
    nomeController = TextEditingController(text: widget.arvore.nome);
    familiaController = TextEditingController(text: widget.arvore.familia);
    idadeAproximadaController = TextEditingController(
      text: widget.arvore.idadeAproximada,
    );
    localizacaoController = TextEditingController(
      text: widget.arvore.localizacao,
    );
    notaController = TextEditingController(text: widget.arvore.nota.toString());
    tipoController = TextEditingController(text: widget.arvore.tipo.toString());
  }

  @override
  void dispose() {
    imagemURLController.dispose();
    nomeController.dispose();
    familiaController.dispose();
    idadeAproximadaController.dispose();
    localizacaoController.dispose();
    notaController.dispose();
    tipoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        spacing: 10,
        children: [
          SizedBox(height: 20),
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 110,
                child: AppTextField(
                  controller: widget.tagIdController,
                  label: "Tag",
                  extraLabel: "Tag YggDrasil",
                  hint: "Digite a Tag da árvore ou escaneie o QR Code",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: IconButton(
                  iconSize: 42,
                  onPressed: widget.abrirScanner,
                  icon: Icon(
                    Icons.qr_code_rounded,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AppTextField(
            controller: imagemURLController,
            label: "URL da Imagem",
            hint: "Link da imagem",
          ),
          AppTextField(
            controller: nomeController,
            label: "Nome",
            hint: "Nome da árvore",
          ),
          AppTextField(
            controller: familiaController,
            label: "Família",
            hint: "Família da árvore",
          ),
          AppTextField(
            controller: idadeAproximadaController,
            label: "Idade Aproximada",
            hint: "Idade da árvore",
          ),
          AppTextField(
            controller: localizacaoController,
            label: "Localização",
            hint: "Localização da árvore",
          ),
          AppTextField(
            controller: notaController,
            label: "Nota",
            hint: "Nota da árvore",
            keyboardType: TextInputType.number,
          ),
          AppTextField(
            controller: tipoController,
            label: "Tipo",
            hint: "Tipo da árvore",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          TransferirButton(
            text: "Criar Árvore",
            onPressed: () {
              final arvoreAtualizada = widget.arvore.copyWith(
                usuarioId: int.tryParse(usuarioIdController.text) ?? 0,
                tagId: int.tryParse(widget.tagIdController.text) ?? 0,
                imagemURL: imagemURLController.text,
                nome: nomeController.text,
                familia: familiaController.text,
                idadeAproximada: idadeAproximadaController.text,
                localizacao: localizacaoController.text,
                nota: int.tryParse(notaController.text) ?? 0,
                tipo: int.tryParse(tipoController.text) ?? 0,
              );
              widget.onSubmit(arvoreAtualizada);
            },
          ),
        ],
      ),
    );
  }
}
