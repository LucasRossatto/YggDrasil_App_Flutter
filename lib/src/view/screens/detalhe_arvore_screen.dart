import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';

class DetalheArvoreScreen extends StatelessWidget {
  final ArvoreModel arvore;
  const DetalheArvoreScreen({super.key, required this.arvore});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView();
  }
}
