// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:html' as html;

Future<bool> loadHourlyPricesCsv() async {
  try {
    final upload = html.FileUploadInputElement()..accept = '.csv';
    upload.click();
    await upload.onChange.first;
    if (upload.files == null || upload.files!.isEmpty) return false;
    final reader = html.FileReader();
    reader.readAsText(upload.files!.first);
    await reader.onLoadEnd.first;
    final content = reader.result as String? ?? '';
    if (content.isEmpty) return false;

    FFAppState().update(() {
      FFAppState().hourlyPricesCsv = content;
    });

    return true;
  } catch (e) {
    return false;
  }
}
