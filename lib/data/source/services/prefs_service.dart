import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  final FlutterSecureStorage _secureStorage;

  const PrefsService(this._secureStorage);

  static const String _hasRunBefore = 'hasRunBefore';

  Future<void> clearOnReinstall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasRunBefore = prefs.getBool(_hasRunBefore);
    if (hasRunBefore == null || !hasRunBefore) {
      await _secureStorage.deleteAll();
      await prefs.setBool(_hasRunBefore, true);
    }
  }

  Future<String?> getItem(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> setItem(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<void> clear() async {
    await (await SharedPreferences.getInstance()).clear();
    await _secureStorage.deleteAll();
  }
}
