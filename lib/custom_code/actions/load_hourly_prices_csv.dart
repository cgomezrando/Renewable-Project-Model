// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:file_picker/file_picker.dart';
import 'dart:convert';

Future<bool> loadHourlyPricesCsv() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return false;
    final bytes = result.files.first.bytes;
    if (bytes == null || bytes.isEmpty) return false;
    final content = utf8.decode(bytes, allowMalformed: true);
    if (content.isEmpty) return false;

    FFAppState().update(() {
      FFAppState().hourlyPricesCsv = content;
    });

    return true;
  } catch (e) {
    return false;
  }
}
