import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/repository/arvore_repositorio.dart';

class ArvoreViewModel extends ChangeNotifier {
  final ArvoreRepositorio _repo = ArvoreRepositorio();

  bool isLoading = false;
  String? erro;

  List<ArvoreModel> arvores = [];
  ArvoreModel? arvore;

  /// Cadastra uma nova árvore
  Future<void> cadastrarArvore(ArvoreModel novaArvore) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      arvore = await _repo.cadastrarArvore(novaArvore);
      // Atualiza a lista local adicionando a nova árvore
      arvores.add(arvore!);
    } catch (e) {
      erro = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Busca todas as árvores de um usuário
  Future<void> getArvoresUsuario(int usuarioId) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      arvores = await _repo.getArvoresUsuario(usuarioId);
    } catch (e) {
      erro = e.toString();
      arvores = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Busca uma árvore específica pelo ID
  Future<void> getArvoreById(int arvoreId) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      arvore = await _repo.getArvoreById(arvoreId);
    } catch (e) {
      erro = e.toString();
      arvore = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Busca uma árvore pelo QR Code
  Future<void> getArvoreByQrCode(String qrCode) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      arvore = await _repo.getArvoreByIdQrCode(qrCode);
    } catch (e) {
      erro = e.toString();
      arvore = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Limpa a árvore selecionada
  void clearSelectedArvore() {
    arvore = null;
    notifyListeners();
  }
}
