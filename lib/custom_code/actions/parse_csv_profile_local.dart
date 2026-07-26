// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

Future<String?> parseCsvProfileLocal(
  FFUploadedFile file,
  int expectedLength,
  bool isGeneration,
) async {
  try {
    if (file.bytes == null || file.bytes!.isEmpty) {
      return 'El archivo está vacío o no se pudo leer';
    }

    String content;
    try {
      content = utf8.decode(file.bytes!);
    } catch (_) {
      content = latin1.decode(file.bytes!);
    }

    if (content.startsWith('\uFEFF')) {
      content = content.substring(1);
    }

    final lines = content
        .split(RegExp(r'\r?\n'))
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    if (lines.isEmpty) {
      return 'El archivo no contiene líneas de datos';
    }

    double? parseLine(String line) {
      var raw = line.replaceAll('"', '').replaceAll("'", '').trim();
      if (raw.contains(';') || raw.contains('\t')) {
        raw = raw.split(RegExp(r'[;\t]')).last.trim();
      }
      raw = raw.replaceAll(',', '.');
      return double.tryParse(raw);
    }

    if (parseLine(lines.first) == null) {
      lines.removeAt(0);
    }

    final values = <double>[];
    for (var i = 0; i < lines.length; i++) {
      final v = parseLine(lines[i]);
      if (v == null) {
        return 'Línea ${i + 1}: valor no numérico ("${lines[i]}")';
      }
      if (v.isNaN || v.isInfinite) {
        return 'Línea ${i + 1}: valor inválido';
      }
      values.add(v);
    }

    if (values.length != expectedLength) {
      return 'Se esperaban $expectedLength valores, se encontraron ${values.length}';
    }

    FFAppState().update(() {
      if (isGeneration) {
        FFAppState().generationProfile = values;
        FFAppState().generationFileUploaded = true;
      } else {
        FFAppState().priceProfile = values;
        FFAppState().priceFileUploaded = true;
      }
    });

    return null;
  } catch (e) {
    return 'Error inesperado: $e';
  }
}
