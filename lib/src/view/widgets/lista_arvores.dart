import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/view/screens/detalhe_arvore_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/arvore_viewmodel.dart';

class ListaArvores extends StatefulWidget {
  final int userId;

  const ListaArvores({super.key, required this.userId});

  @override
  State<ListaArvores> createState() => _ListaArvoresState();
}

class _ListaArvoresState extends State<ListaArvores> {
  late ArvoreViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ArvoreViewModel();
    _carregarArvores();
  }

  Future<void> _carregarArvores({bool carregarMais = false}) async {
    await _viewModel.getArvoresUsuario(
      widget.userId,
      carregarMais: carregarMais,
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final arvoreVm = context.read<ArvoreViewModel>();

    if (_viewModel.isLoading && _viewModel.arvores.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_viewModel.erro != null) {
      return Center(child: Text('Erro: ${_viewModel.erro}'));
    }

    if (_viewModel.arvores.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Text(
              "Nenhuma Árvore encontrada",
              style: TextStyle(
                color: theme.colorScheme.inverseSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        // Barra superior com botão de recarregar
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        child: Text(
                          "Minhas Árvores",
                          style: TextStyle(
                            color: theme.colorScheme.surface,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                color: theme.colorScheme.primary,
                onPressed: () => _carregarArvores(),
              ),
            ],
          ),
        ),

        // Lista de árvores
        ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _viewModel.temMais
              ? _viewModel.arvores.length + 1
              : _viewModel.arvores.length,
          itemBuilder: (context, index) {
            if (index == _viewModel.arvores.length) {
              // botão carregar mais
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: _viewModel.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _carregarArvores(carregarMais: true),
                          child: const Text("Carregar mais"),
                        ),
                ),
              );
            }

            final arvore = _viewModel.arvores[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  leading: SvgPicture.asset('assets/Icons/Icone_YGGTAGG.svg'),
                  title: Text(
                    arvore.nome,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  subtitle: Text(
                    arvore.familia,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  trailing: Text(
                    "TAG: ${arvore.tagId}",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final arvoreDetalhada = await arvoreVm.getArvoreById(
                      arvore.id,
                    );
                    if (context.mounted && arvoreDetalhada != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetalheArvoreScreen(arvore: arvoreDetalhada, usuarioId: widget.userId,),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
