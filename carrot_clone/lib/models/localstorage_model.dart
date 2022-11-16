import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageModel {
  final storage = const FlutterSecureStorage();

  Future<String> get(String key) async {
    try {
      return await storage.read(key: key) ?? "";
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> set(String key, String value) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      throw Exception(e);
    }
  }
}
