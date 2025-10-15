import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/models/avaliacao_model.dart';
import 'package:yggdrasil_app/src/repository/arvore_repositorio.dart';

class ArvoreViewModel extends ChangeNotifier {
  final ArvoreRepositorio _repo = ArvoreRepositorio();

  bool isLoading = false;
  String? erro;
  int _page = 1;
  final int _size = 5;
  int qtdeTotal = 0;

  List<ArvoreModel> _arvoresOriginais = [];
  List<ArvoreModel> arvores = [];
  ArvoreModel? arvore;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void ordenarPorAlfabetica() {
    arvores = List.from(_arvoresOriginais)
      ..sort((a, b) => a.nome.compareTo(b.nome));
    notifyListeners();
  }

  void ordenarPorUltimaFiscalizacao() {
    arvores = List.from(_arvoresOriginais)
      ..sort((a, b) => b.ultimaFiscalizacao.compareTo(a.ultimaFiscalizacao));
    notifyListeners();
  }

  void ordenarPorMaisRecente() {
    arvores = List.from(_arvoresOriginais)
      ..sort((a, b) => b.id.compareTo(a.id));
    notifyListeners();
  }

  Future<bool> verificarTag(String tagId) async {
    setLoading(true);
    erro = null;
    notifyListeners();
    try {
      final res = await _repo.verificarTag(tagId);

      if (res.message == "TAG inválida") {
        erro = "TAG inválida";
        return false;
      }
      return true;
    } catch (e) {
      erro = e.toString();
      debugPrint(erro);
      return false;
    } finally {
      setLoading(false);
      notifyListeners();
    }
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
      final novaCriada = await getArvoreById(res.idArvore);
      if (novaCriada != null) {
        _arvoresOriginais.add(novaCriada);
        arvores = List.from(_arvoresOriginais);
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
  Future<void> getArvoresUsuario(
    int usuarioId, {
    bool carregarMais = false,
  }) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      if (!carregarMais) {
        _page = 1;
        arvores.clear();
      } else {
        _page++;
      }

      final resultado = await _repo.getArvoresUsuario(
        usuarioId,
        page: _page,
        size: _size,
      );

      final List<ArvoreModel> novas = resultado["arvores"];
      qtdeTotal = resultado["qtdeTotal"];
      _arvoresOriginais.addAll(novas);
      arvores = List.from(_arvoresOriginais);
    } on Exception catch (e) {
      erro = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool get temMais => arvores.length < qtdeTotal;

  /// Busca uma árvore específica pelo ID
  Future<ArvoreModel?> getArvoreById(int arvoreId) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      arvore = await _repo.getArvoreById(arvoreId);
      if (arvore != null) {
        notifyListeners();
      }
      return arvore;
    } catch (e) {
      erro = e.toString();
      arvore = null;
      return null;
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
        tag: res.tag,
        id: 0,
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
        sccAcumulado: res.sccAcumulado,
        sccGerado: res.sccGerado,
        sccLiberado: res.sccLiberado,
        ultimaFiscalizacao: res.ultimaFiscalizacao,
        ultimaValidacao: res.ultimaValidacao,
        ultimaAtualizacaoImagem: res.ultimaAtualizacaoImagem,
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

  Future<int?> fiscalizar(AvaliacaoModel avaliacao) async {
    setLoading(true);
    erro = null;
    try {
      final res = await _repo.fiscalizar(avaliacao);
      if (res?.message == "Essa etiqueta não foi vinculada a nenhuma arvore") {
        erro = "Essa etiqueta não foi vinculada a nenhuma arvore";
        return null;
      } else if (res?.message == "Você já fiscalizou essa arvore hoje!") {
        erro = "Você já fiscalizou essa arvore hoje, Tente novamente amanhã";
        return null;
      } else if (res?.message ==
          "Não existem usuários o suficiente para iniciar a operação") {
        erro = "Não existem usuários o suficiente para iniciar a operação";
        return null;
      } else if (res?.success == 0) {
        erro = "Os dados inseridos não foram inválidos";
        return null;
      }
      return res?.success;
    } catch (e) {
      erro = "Erro interno ao enviar imagem. ,$e";
      return null;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  /// Limpa a árvore selecionada
  void clearSelectedArvore() {
    arvore = null;
    notifyListeners();
  }
}
