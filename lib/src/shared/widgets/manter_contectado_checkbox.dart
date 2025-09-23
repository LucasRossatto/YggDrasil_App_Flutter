import 'package:flutter/material.dart';

class ManterContectadoCheckbox extends StatefulWidget {
  const ManterContectadoCheckbox({super.key});

  @override
  State<ManterContectadoCheckbox> createState() => _ManterContectadoCheckbox();
}

class _ManterContectadoCheckbox extends State<ManterContectadoCheckbox> {
  bool _manterConectado = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _manterConectado,
          onChanged: (bool? value) {
            setState(() {
              _manterConectado = value ?? false;
            });
          },
        ),
        const Text("Mantenha-me conectado"),
      ],
    );
  }
}
