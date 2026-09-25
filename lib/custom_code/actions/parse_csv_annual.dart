// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

Future<bool> parseCsvAnnual(
  String csvContent,
  String targetKey,
  int expectedRows,
) async {
  if (csvContent.isEmpty) return false;

  final lines = csvContent
      .split(RegExp(r'\r?\n'))
      .where((l) => l.trim().isNotEmpty)
      .toList();

  if (lines.isEmpty) return false;

  final values = <double>[];
  bool firstLineIsHeader = false;

  final firstCells = lines[0].split(RegExp(r'[,;\t]'));
  final firstNumericTest = firstCells.length > 1
      ? firstCells[1].trim().replaceAll(',', '.')
      : firstCells[0].trim().replaceAll(',', '.');
  if (double.tryParse(firstNumericTest) == null) {
    firstLineIsHeader = true;
  }

  final startIdx = firstLineIsHeader ? 1 : 0;

  for (int i = startIdx; i < lines.length; i++) {
    final cells = lines[i].split(RegExp(r'[,;\t]'));
    if (cells.isEmpty) continue;

    final raw =
        (cells.length > 1 ? cells[1] : cells[0]).trim().replaceAll(',', '.');
    final v = double.tryParse(raw);
    if (v == null) continue;
    values.add(v);
  }

  if (values.isEmpty) return false;

  while (values.length < expectedRows) {
    values.add(values.last);
  }
  if (values.length > expectedRows) {
    values.removeRange(expectedRows, values.length);
  }

  FFAppState().update(() {
    switch (targetKey) {
      case 'marketPrices':
        FFAppState().annualMarketPrices = values;
        break;
      case 'captureRates':
        FFAppState().annualCaptureRates = values;
        break;
      case 'capturedPrices':
        FFAppState().annualCapturedPrices = values;
        break;
    }
  });

  return true;
}
