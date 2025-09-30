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
  Future<int?> cadastrarArvore(ArvoreModel arvore) async {
    setLoading(true);
    erro = null;
    notifyListeners();

    try {
      final res = await _repo.cadastrarArvore(arvore);
      debugPrint("res: $res, idArvore: ${res.idArvore}");

      if (res.success == 0) {
        erro = "Não foi possível cadastrar a árvore";
        return null;
      }

      if (res.message == "TAG inválida") {
        erro = "TAG inválida";
        return null;
      }

      return res.idArvore;
    } catch (e) {
      erro = e.toString();
      debugPrint(erro);
      return null;
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
  Future<ArvoreModel?> getArvoreByQrCode(String qrCode) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      final res = await _repo.getArvoreByIdQrCode(qrCode);

      if (res == null) {
        throw Exception("Árvore não encontrada para o QRCode: $qrCode");
      }

      arvore = ArvoreModel(
        usuarioId: res.usuarioId,
        tagId: res.tagId.toString(),
        imagemURL: res.imagemURL,
        nome: res.nome,
        familia: res.familia,
        mensagem: res.mensagem,
        idadeAproximada: res.idadeAproximada,
        localizacao: res.localizacao,
        nota: res.nota,
        tipo: res.tipo,
      );

      return arvore;
    } catch (e) {
      debugPrint("Erro ao buscar árvore: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<ApiResponse?> enviarImagem(String image, int id) async {
    setLoading(true);
    erro = null;

    try {
      final res = await _repo.enviarImagem(image, id);

      // Garante que o res tenha o formato esperado
      if (res is Map<String, dynamic>) {
        final apiResponse = ApiResponse.fromJson(res);

        switch (apiResponse.success) {
          case 0:
            erro = "Os dados da imagem não são válidos.";
            return null;
          case 2:
            erro = "ID de árvore não encontrado.";
            return null;
          default:
            return apiResponse;
        }
      } else {
        erro = "Resposta inesperada do servidor.";
        return null;
      }
    } catch (e, stack) {
      debugPrint("Erro ao enviar imagem: $e\n$stack");
      erro = "Erro interno ao enviar imagem.";
      return null;
    } finally {
      setLoading(false);
    }
  }

  /// Limpa a árvore selecionada
  void clearSelectedArvore() {
    arvore = null;
    notifyListeners();
  }
}
