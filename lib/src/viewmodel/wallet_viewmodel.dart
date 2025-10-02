import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/repository/wallet_repositorio.dart';

class WalletViewmodel extends ChangeNotifier {
  final WalletRepositorio _repo = WalletRepositorio();

  bool isLoading = false;
  UsuarioModel? usuario;
  WalletModel? wallet;
  int? qtdeTagsTotal;
  String? erro;

  Future<bool> validarTransferencia(
    String walletSaida,
    String walletDestino,
    int quantidade,
    String tipo,
    WalletModel? wallet,
  ) async {
    final DadosTransferencia dados = DadosTransferencia(
      walletSaida: walletSaida,
      walletDestino: walletDestino,
      quantidade: quantidade,
      tipo: tipo,
    );

    try {
      // Validação local: carteira existe
      if (wallet == null) {
        erro = "Essa carteira não existe...";
        return false;
      }

      // Validação local: tipo YGG
      if (tipo == "YGG") {
        if ((wallet.yggCoin) < quantidade) {
          erro = "Você não possue YggCoins suficientes para essa transação";
          return false;
        }
      } else if (tipo == "SCC") {
          erro = "Você não possue SCCs suficientes para essa transação";
          return false;
      } else {
        erro = "Tipo de moeda inválido";
        return false;
      }
      
      final res = await _repo.validarTransferencia(dados);
      if (res.success == 0) {
        erro = "Transação inválida";
        return false;
      }

      return res.success == 1;
    } catch (e) {
      erro = 'Erro ao validar transferência: $e';
      return false;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<bool> transferir(DadosTransferencia dadosTransferencia) async {
    try {
      final res = await _repo.transferir(dadosTransferencia);
      if (res.success == 0) {
        erro = "Houve um erro ao realizar a transferencia";
        return false;
      }
      return res.success == 1;
    } catch (e) {
      erro = 'Houve um erro ao realizar a transferencia: $e';
      return false;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
