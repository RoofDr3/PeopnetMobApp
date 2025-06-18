import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalJsonStorage {
  static Future<File> _getLocalFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$filename');
  }

  static Future<void> writeJson(String filename, dynamic data) async {
    final file = await _getLocalFile(filename);
    final jsonStr = jsonEncode(data);
    await file.writeAsString(jsonStr);
  }

  static Future<dynamic> readJson(String filename) async {
    try {
      final file = await _getLocalFile(filename);
      if (!await file.exists()) return null;
      final jsonStr = await file.readAsString();
      return jsonDecode(jsonStr);
    } catch (e) {
      return null;
    }
  }
}
