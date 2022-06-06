import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class StorageService {
  final Logger _logger = Logger();
  static late StorageService _instance;
  static late SharedPreferences _preferences;
  static late FirebaseStorage _firebaseStorage;

  static Future<StorageService> getInstance() async {
    _instance = StorageService();

    _preferences = await SharedPreferences.getInstance();
    _firebaseStorage = FirebaseStorage.instance;

    return _instance;
  }

  Reference get storageRef => _firebaseStorage.ref();

  dynamic uploadFileToCloud(String path, String name, Reference ref) async {
    File file = File(path);
    try {
      await ref.putFile(file);
    } on FirebaseException catch (e) {
      _logger.e(e.message);
    }
  }

  dynamic getFileFromCloud(Reference ref) async {
    return await ref.getDownloadURL();
  }

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  void saveToDisk<T>(String key, T content) {
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
