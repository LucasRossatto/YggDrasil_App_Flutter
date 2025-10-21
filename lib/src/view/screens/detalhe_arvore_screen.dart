import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/base64_image.dart';
import 'package:yggdrasil_app/src/shared/widgets/formatar_data.dart';
import 'package:yggdrasil_app/src/shared/widgets/mapa.dart';
import 'package:yggdrasil_app/src/view/widgets/fiscalizar_dialog.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';

class DetalheArvoreScreen extends StatelessWidget {
  final ArvoreModel arvore;
  final int usuarioId;
  const DetalheArvoreScreen({
    super.key,
    required this.arvore,
    required this.usuarioId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coords = arvore.localizacao.split(',');
    final lat = double.tryParse(coords[0]) ?? 0;
    final lng = double.tryParse(coords[1]) ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Árvore"),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Base64Image(
                base64String: arvore.imagemURL,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                backgroundColor: theme.colorScheme.outline,

                placeholder: Icon(
                  Icons.image_not_supported_outlined,
                  size: 50,
                  color: theme.colorScheme.surface,
                ),
              ),
              SizedBox(height: 30),
              // Infos container1: nome, tipo, familia, ultima fiscalizacao, scc acumulado, idade aproximada
              infoContainer1(arvore: arvore),
              SizedBox(height: 26),
              // Infos container2: tag, localização
              InfoContainer2(theme: theme, arvore: arvore),
              SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 380,
                  height: 222,
                  child: SimpleMap(latitude: lat, longitude: lng),
                ),
              ),
              SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: InfoRow(
                  label: "Historia",
                  value: arvore.mensagem,
                  valueFontSize: 16,
                  labelFontSize: 16,
                ),
              ),
              if (arvore.tag.epc.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: TransferirButton(
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) => AvaliacaoDialog(
                          usuarioId: usuarioId,
                          arvore: arvore,
                        ),
                      );
                    },
                    text: "Fiscalizar Árvore",
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoContainer2 extends StatelessWidget {
  const InfoContainer2({super.key, required this.theme, required this.arvore});

  final ThemeData theme;
  final ArvoreModel arvore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (arvore.tag.epc.isNotEmpty)
            Text(
              "Identificação",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          SizedBox(height: 10),
          if (arvore.tag.epc.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "TAG: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  arvore.tag.codigo,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          if (arvore.tag.epc.isNotEmpty) SizedBox(height: 20),

          Text(
            // Titulo
            "Localização",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Coordenadas",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  arvore.localizacao,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  softWrap: true,
                  overflow: TextOverflow
                      .ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class infoContainer1 extends StatelessWidget {
  const infoContainer1({super.key, required this.arvore});

  final ArvoreModel arvore;

  String mostrarUltimaFiscalizacao(data) {
    final dataPadrao = "01/01/0001";
    if (data == dataPadrao) {
      return "Não fiscalizada";
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 6,
        children: [
          InfoRow(
            label: "Nome",
            value: arvore.nome,
            valueFontSize: 22,
            labelFontSize: 22,
          ),
          InfoRow(
            label: "Tipo",
            value: arvore.getTipo(arvore.tipo),
            valueFontSize: 16,
            labelFontSize: 16,
          ),
          InfoRow(
            label: "Nome científico",
            value: arvore.familia,
            valueFontSize: 16,
            labelFontSize: 16,
          ),
          InfoRow(
            label: "Última Fiscalização",
            value: mostrarUltimaFiscalizacao(
              formatarData(arvore.ultimaFiscalizacao),
            ),
            valueFontSize: 16,
            labelFontSize: 16,
          ),
          InfoRow(
            label: "SCC Gerado",
            value: arvore.sccGerado.toString(),
            valueFontSize: 16,
            labelFontSize: 16,
          ),
          InfoRow(
            label: "SCC Acumulado",
            value: arvore.sccAcumulado.toString(),
            valueFontSize: 16,
            labelFontSize: 16,
          ),
          InfoRow(
            label: "SCC Liberado",
            value: arvore.sccLiberado.toString(),
            valueFontSize: 16,
            labelFontSize: 16,
          ),

          InfoRow(
            label: "Idade Aproximada",
            value: arvore.idadeAproximada,
            valueFontSize: 16,
            labelFontSize: 16,
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final double? labelFontSize;
  final double? valueFontSize;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final double spacing;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelFontSize,
    this.valueFontSize,
    this.valueStyle,
    this.labelStyle,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style:
              labelStyle ??
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: labelFontSize ?? 14,
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: Text(
            value,
            style:
                valueStyle ??
                TextStyle(
                  fontSize: valueFontSize ?? 16,
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ],
    );
  }
}
