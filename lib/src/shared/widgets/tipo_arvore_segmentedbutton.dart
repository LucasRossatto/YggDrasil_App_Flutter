import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipoArvoreSegmented extends StatefulWidget {
  final TextEditingController tipoController;
  final String? label;

  const TipoArvoreSegmented({
    super.key,
    required this.tipoController,
    this.label,
  });

  @override
  State<TipoArvoreSegmented> createState() => _TipoArvoreSegmentedState();
}

class _TipoArvoreSegmentedState extends State<TipoArvoreSegmented> {
  int selectedTipo = 1; // valor padrão

  @override
  void initState() {
    super.initState();

    // Se o controller já tiver valor, sincroniza o estado
    if (widget.tipoController.text.isNotEmpty) {
      final parsed = int.tryParse(widget.tipoController.text);
      if (parsed != null) {
        selectedTipo = parsed;
      }
    } else {
      widget.tipoController.text = selectedTipo.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = widget.label;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SegmentedButton<int>(
          segments: const <ButtonSegment<int>>[
            ButtonSegment<int>(
              value: 1,
              label: Text('Não-frutífera'),
              icon: Icon(Icons.forest_outlined),
            ),
            ButtonSegment<int>(
              value: 2,
              label: Text('Frutífera'),
              icon: Icon(FontAwesomeIcons.appleWhole),
            ),
          ],
          selected: <int>{selectedTipo},
          onSelectionChanged: (Set<int> newSelection) {
            setState(() {
              selectedTipo = newSelection.first;
              widget.tipoController.text = selectedTipo.toString();
            });
          },
          style: const ButtonStyle(visualDensity: VisualDensity.comfortable),
        ),
      ],
    );
  }
}
