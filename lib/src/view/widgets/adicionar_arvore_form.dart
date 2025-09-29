import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  late TextEditingController nomeController;
  late TextEditingController familiaController;
  late TextEditingController idadeAproximadaController;

  @override
  void initState() {
    super.initState();
    usuarioIdController = TextEditingController(
      text: widget.arvore.usuarioId.toString(),
    );
    nomeController = TextEditingController(text: widget.arvore.nome);
    familiaController = TextEditingController(text: widget.arvore.familia);
    idadeAproximadaController = TextEditingController(
      text: widget.arvore.idadeAproximada,
    );
  }

  @override
  void dispose() {
    usuarioIdController.dispose();
    nomeController.dispose();
    familiaController.dispose();
    idadeAproximadaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingHorizontal = screenWidth * 0.05; // 5% da largura da tela
    final spacingVertical = screenHeight * 0.02; // 2% da altura da tela

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: spacingVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacingVertical),
          Text(
            "Tag",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: AppTextField(
                  controller: widget.tagIdController,
                  label: "Digite ou escaneiro o QR code",
                  hint: "Digite a Tag da árvore ou escaneie o QR Code",
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: widget.abrirScanner,
                  iconSize: screenWidth * 0.08,
                  icon: SvgPicture.asset(
                    'assets/Icons/Icone_YGGTAGG.svg',
                    // ignore: deprecated_member_use
                    color: Theme.of(context).colorScheme.surface,
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                  ),
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
          SizedBox(height: spacingVertical),
          AppTextField(
            controller: nomeController,
            label: "Nome",
            hint: "Nome da árvore",
            extraLabel: "Nome",
          ),
          SizedBox(height: spacingVertical),
          AppTextField(
            controller: familiaController,
            label: "Família",
            hint: "Família da árvore (Nome Científico)",
            extraLabel: "Família",
          ),
          SizedBox(height: spacingVertical),
          AppTextField(
            controller: idadeAproximadaController,
            label: "Idade Aproximada",
            hint: "Idade da árvore",
            extraLabel: "Idade",
          ),
          SizedBox(height: MediaQuery.of(context).size.width - 110),
          SizedBox(
            width: double.infinity,
            child: TransferirButton(
              text: "Criar Árvore",
              onPressed: () {
                final arvoreAtualizada = widget.arvore.copyWith(
                  usuarioId: int.tryParse(usuarioIdController.text) ?? 0,
                  tagId: int.tryParse(widget.tagIdController.text) ?? 0,
                  imagemURL: '',
                  nome: nomeController.text,
                  familia: familiaController.text,
                  idadeAproximada: idadeAproximadaController.text,
                  nota: 0,
                  tipo: 0
                );
                widget.onSubmit(arvoreAtualizada);
              },
            ),
          ),
        ],
      ),
    );
  }
}
