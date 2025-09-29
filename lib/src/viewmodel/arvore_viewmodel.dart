import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/repository/arvore_repositorio.dart';

class ArvoreViewModel extends ChangeNotifier {
  final ArvoreRepositorio _repo = ArvoreRepositorio();

  bool isLoading = false;
  String? erro;

  List<ArvoreModel> arvores = [];
  ArvoreModel? arvore;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Cadastra uma nova árvore
  Future<bool> cadastrarArvore(ArvoreModel arvore) async {
    setLoading(true);
    erro = null;
    notifyListeners();

    try {
      final res = await _repo.cadastrarArvore(
        arvore,
      );

      if (res.success == 0) {
        erro =  "Não foi possível cadastrar a árvore";
        return false;
      }

      if (res.message == "TAG inválida") {
        erro =  "TAG inválida";
        return false;
      }

      debugPrint("Árvore cadastrada com ID: ${res.idArvore}");
      return true;
    } catch (e) {
      erro = e.toString();
      return false;
    } finally {
      setLoading(false);
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
