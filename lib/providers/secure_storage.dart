import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _urlKey = 'url';
  final String _usernameKey = 'username';
  final String _passwordKey = 'password';

  Future setURL(String url) async {
    await storage.write(key: _urlKey, value: url);
  }

  Future<String?> getURL() async {
    return await storage.read(key: _urlKey);
  }

  Future setUsername(String username) async {
    await storage.write(key: _usernameKey, value: username);
  }

  Future<String?> getUsername() async {
    return await storage.read(key: _usernameKey);
  }

  Future setPassword(String password) async {
    await storage.write(key: _passwordKey, value: password);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: _passwordKey);
  }

  Future eraseAll() async {
    await storage.delete(key: _urlKey);
    await storage.delete(key: _usernameKey);
    await storage.delete(key: _passwordKey);
  }
}
