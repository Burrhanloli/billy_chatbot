import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedName = formatter.format(now);
    return File('$path/$formattedName').create(recursive: true);
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data", mode: FileMode.write);
  }

  Future<dynamic> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      if (body.isEmpty) {
        return jsonDecode("[]");
      }
      return jsonDecode(body);
    } catch (e) {
      print(e);
      return jsonDecode("[]");
    }
  }

  Future<bool> exists() async {
    final file = await localFile;
    return await file.exists();
  }

  Future<void> delete() async {
    final file = await localFile;
    return file.exists();
  }
}
