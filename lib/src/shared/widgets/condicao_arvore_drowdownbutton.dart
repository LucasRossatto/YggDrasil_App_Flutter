import 'package:flutter/material.dart';

class CondicaoArvoreDropdown extends StatefulWidget {
  final TextEditingController controller;
  final bool isLeigo; // true = lista leigo, false = lista fiscal

  const CondicaoArvoreDropdown({
    super.key,
    required this.controller,
    this.isLeigo = true,
  });

  @override
  State<CondicaoArvoreDropdown> createState() => _CondicaoArvoreDropdownState();
}

class _CondicaoArvoreDropdownState extends State<CondicaoArvoreDropdown> {
  String? selectedCondition;

  final List<Map<String, dynamic>> condicoesLeigos = [
    {
      'label': 'Muito boa',
      'icon': Icons.sentiment_very_satisfied,
      'iconColor': Colors.green,
      'description': 'Árvore em ótimo estado, saudável',
    },
    {
      'label': 'Boa',
      'icon': Icons.sentiment_satisfied,
      'iconColor': Colors.lightGreen,
      'description': 'Árvore saudável, pequeno cuidado necessário',
    },
    {
      'label': 'Regular',
      'icon': Icons.sentiment_neutral,
      'iconColor': Colors.yellow,
      'description': 'Árvore com condições medianas',
    },
    {
      'label': 'Muito ruim',
      'icon': Icons.sentiment_very_dissatisfied,
      'iconColor': Colors.red,
      'description': 'Árvore em péssimo estado, precisa de atenção',
    },
    {
      'label': 'Ruim',
      'icon': Icons.sentiment_dissatisfied,
      'iconColor': Colors.orange,
      'description': 'Árvore em estado ruim, alguns problemas visíveis',
    },
  ];

  final List<Map<String, dynamic>> condicoesFiscal = [
    {
      'label': 'Saudável',
      'icon': Icons.check_circle,
      'iconColor': Colors.green,
      'description': 'Árvore em bom estado, sem sinais de doença',
    },
    {
      'label': 'Doente',
      'icon': Icons.warning,
      'iconColor': Colors.red,
      'description': 'Árvore com doenças ou pragas visíveis',
    },
    {
      'label': 'Seca',
      'icon': Icons.local_florist,
      'iconColor': Colors.brown,
      'description': 'Árvore sem folhas ou com falta de água',
    },
    {
      'label': 'Recuperando',
      'icon': Icons.autorenew,
      'iconColor': Colors.orange,
      'description': 'Árvore em processo de recuperação',
    },
    {
      'label': 'Crescendo',
      'icon': Icons.nature,
      'iconColor': Colors.lightGreen,
      'description': 'Árvore jovem em crescimento saudável',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      selectedCondition = widget.controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final options = widget.isLeigo ? condicoesLeigos : condicoesFiscal;

    return IntrinsicHeight(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Condição da Árvore',
          hintText: 'Selecione a condição',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
        initialValue: selectedCondition,
        items: options.map((condicao) {
          return DropdownMenuItem<String>(
            value: condicao['label'] as String,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  condicao['icon'] as IconData,
                  color: condicao['iconColor'] as Color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                // NÃO usar Expanded ou Flexible aqui
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      condicao['label'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      width:
                          200, // define largura máxima do texto para não estourar
                      child: Text(
                        condicao['description'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.secondary,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),

        selectedItemBuilder: (BuildContext context) {
          return options.map((condicao) {
            return Row(
              children: [
                Icon(
                  condicao['icon'] as IconData,
                  color: condicao['iconColor'] as Color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  condicao['label'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            );
          }).toList();
        },

        onChanged: (value) {
          setState(() {
            selectedCondition = value;
            widget.controller.text = value ?? '';
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Informe a condição da árvore";
          }
          return null;
        },
      ),
    );
  }
}
