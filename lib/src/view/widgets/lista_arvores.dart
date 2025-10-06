import 'package:flutter/material.dart';
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
  bool _inicializado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_inicializado) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final vm = context.read<ArvoreViewModel>();
        vm.getArvoresUsuario(widget.userId);
      });
      _inicializado = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ArvoreViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading && vm.arvores.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: RefreshProgressIndicator(),
            ),
          );
        }

        return Column(
          children: [
            // Cabeçalho com botão de recarregar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
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
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    color: theme.colorScheme.primary,
                    onPressed: () => vm.getArvoresUsuario(widget.userId),
                  ),
                ],
              ),
            ),

            // Lista
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vm.temMais ? vm.arvores.length + 1 : vm.arvores.length,
              itemBuilder: (context, index) {
                if (index == vm.arvores.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: vm.isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () => vm.getArvoresUsuario(
                                widget.userId,
                                carregarMais: true,
                              ),
                              child: const Text("Ver mais"),
                            ),
                    ),
                  );
                }

                final arvore = vm.arvores[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/images/logo-yggdrasil.png'),
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
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      trailing: Text(
                        "TAG ${arvore.tag.codigo}",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      onTap: () async {
                        final arvoreDetalhada = await vm.getArvoreById(
                          arvore.id,
                        );
                        if (context.mounted && arvoreDetalhada != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalheArvoreScreen(
                                arvore: arvoreDetalhada,
                                usuarioId: widget.userId,
                              ),
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
      },
    );
  }
}
