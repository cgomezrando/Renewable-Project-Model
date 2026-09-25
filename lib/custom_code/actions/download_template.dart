// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadTemplate(String url, String fileName) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Error descargando plantilla: ${response.statusCode}');
    }

    // Guardar archivo localmente en iOS
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    
    await file.writeAsBytes(response.bodyBytes);
    
    print('Archivo descargado en: $filePath');
    
  } catch (e) {
    print('Error en downloadTemplate: $e');
    rethrow;
  }
}
