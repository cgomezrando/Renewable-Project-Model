// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';

String opexBandsJsonString() {
  final mode = FFAppState().opexMode;
  final bands = FFAppState().opexWtgBands;
  if (mode == 'bands' && bands.length == 7) {
    return jsonEncode(bands);
  }
  return '[]';
}
