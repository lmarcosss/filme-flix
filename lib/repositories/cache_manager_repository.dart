import 'package:filme_flix/get_it_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManagerRepository {
  static final SharedPreferences _storage = getIt<SharedPreferences>();

  static Future<void> save({
    required String key,
    required String value,
    Duration duration = const Duration(minutes: 3),
  }) async {
    final expiryTime = DateTime.now().add(duration).millisecondsSinceEpoch;

    await _storage.setString(key, value);
    await _storage.setInt(_expiryKey(key), expiryTime);
  }

  static Future<String?> get({required String key}) async {
    final expiry = _storage.getInt(_expiryKey(key));

    if (expiry != null && DateTime.now().millisecondsSinceEpoch > expiry) {
      await remove(key);
      return null;
    }

    return _storage.getString(key);
  }

  static Future<void> remove(String key) async {
    await _storage.remove(key);
    await _storage.remove(_expiryKey(key));
  }

  static String _expiryKey(String key) => '${key}_expiry';
}
