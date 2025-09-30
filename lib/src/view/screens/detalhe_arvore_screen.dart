import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';

class DetalheArvoreScreen extends StatelessWidget {
  final ArvoreModel arvore;
  const DetalheArvoreScreen({super.key, required this.arvore});

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(arvore.nome),
            Text(arvore.tipo.toString()),
            Text(arvore.familia),
            Text(arvore.idadeAproximada),
          ],
        ),
      ),
    );
  }
}
