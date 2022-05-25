import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late StorageService _instance;
  static late SharedPreferences _preferences;

  static Future<StorageService?> getInstance() async {
    _instance = StorageService();

    _preferences = await SharedPreferences.getInstance();

    return _instance;
  }

  static const String UserKey = 'user';

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  void removeFromDisk(String key) async {
    await _preferences.remove(key);
  }
}
