// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

import 'package:url_launcher/url_launcher.dart';

Future<void> downloadTemplate(String url, String fileName) async {
  if (url.isEmpty) return;

  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('downloadTemplate: no se puede abrir la URL $url');
    }
  } catch (e) {
    print('downloadTemplate error: $e');
  }
}
