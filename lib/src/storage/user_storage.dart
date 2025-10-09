import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';

class UserStorage {
  static const _keyUserId = 'usuario_id';
  static const _keyUsuario = 'usuario';
  static const _keyWallet = 'wallet';

  // Salvar id do usuário
  Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, id);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }

  // Salvar dados completos do usuário
  Future<void> saveUsuario(UsuarioModel usuario) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(usuario.toJson());
    await prefs.setString(_keyUsuario, jsonString);
  }

  Future<UsuarioModel?> getUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUsuario);
    if (jsonString == null) return null;
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return UsuarioModel.fromJson(data);
  }

  Future<void> clearUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsuario);
  }

  // Salvar Wallet
  Future<void> saveWallet(WalletModel wallet) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(wallet.toJson());
    await prefs.setString(_keyWallet, jsonString);
  }

  Future<WalletModel?> getWallet() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyWallet);
    if (jsonString == null) return null;
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return WalletModel.fromJson(data);
  }

  Future<void> clearWallet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyWallet);
  }

  // Limpar tudo
  Future<void> clearAll() async {
    await clearUserId();
    await clearUsuario();
    await clearWallet();
  }
}
