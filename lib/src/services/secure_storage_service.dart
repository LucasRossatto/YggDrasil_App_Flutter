import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static late final FlutterSecureStorage _secureStorage;
  static void init() => _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

 Future<void> saveData(String key, String value) async {
  log('[SecureStorage] write → key: $key | value: $value');
  await _secureStorage.write(key: key, value: value);
}

  Future<String?> readData(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> hasKey (String key) => _secureStorage.containsKey(key: key);
}
