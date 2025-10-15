import 'dart:convert';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/services/secure_storage_service.dart';

class UserStorage {
  final SecureStorageService storageService = SecureStorageService();

  static const _keyUserId = 'usuario_id';
  static const _keyUsuario = 'usuario';
  static const _keyWallet = 'wallet';

  // Salvar ID do usuário
  Future<void> saveUserId(int id) async {
    await storageService.saveData(_keyUserId, id.toString());
  }

  Future<int?> getUserId() async {
    final value = await storageService.readData(_keyUserId);
    return value != null ? int.tryParse(value) : null;
  }

  Future<void> clearUserId() async {
    await storageService.deleteData(_keyUserId);
  }

  // Salvar dados completos do usuário
  Future<void> saveUsuario(UsuarioModel usuario) async {
    final jsonString = jsonEncode(usuario.toJson());
    await storageService.saveData(_keyUsuario, jsonString);
  }

  Future<UsuarioModel?> getUsuario() async {
    final jsonString = await storageService.readData(_keyUsuario);
    if (jsonString == null) return null;
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return UsuarioModel.fromJson(data);
  }

  Future<void> clearUsuario() async {
    await storageService.deleteData(_keyUsuario);
  }

  // Salvar Wallet
  Future<void> saveWallet(WalletModel wallet) async {
    final jsonString = jsonEncode(wallet.toJson());
    await storageService.saveData(_keyWallet, jsonString);
  }

  Future<WalletModel?> getWallet() async {
    final jsonString = await storageService.readData(_keyWallet);
    if (jsonString == null) return null;
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return WalletModel.fromJson(data);
  }

  Future<void> clearWallet() async {
    await storageService.deleteData(_keyWallet);
  }

  // Limpar tudo
  Future<void> clearAll() async {
    await storageService.clearAll();
  }
}
