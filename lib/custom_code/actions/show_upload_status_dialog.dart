// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

import '/app_state.dart';

Future<void> showUploadStatusDialog(
  BuildContext context,
  String? errorMessage,
) async {
  final bool genUploaded = FFAppState().generationFileUploaded;
  final bool priceUploaded = FFAppState().priceFileUploaded;

  // FlutterFlow a veces envía el texto "null" en vez de un null real.
  final String? normalizedError = errorMessage?.trim();

  final bool hasError = normalizedError != null &&
      normalizedError.isNotEmpty &&
      normalizedError.toLowerCase() != 'null';

  String title;
  String message;
  IconData iconData;
  Color accentColor;
  Color accentBg;

  if (hasError) {
    title = 'Error al procesar el archivo';
    message = normalizedError;
    iconData = Icons.error_outline;
    accentColor = const Color(0xFFDC2626);
    accentBg = const Color(0xFFFEE2E2);
  } else if (genUploaded && priceUploaded) {
    title = 'Perfiles cargados correctamente';
    message =
        'Los perfiles horarios de generación y precios se han cargado correctamente. Ya puedes cerrar este diálogo y ejecutar el cálculo horario.';
    iconData = Icons.check_circle;
    accentColor = const Color(0xFF16A34A);
    accentBg = const Color(0xFFDCFCE7);
  } else if (genUploaded && !priceUploaded) {
    title = 'Falta subir el perfil de precios';
    message =
        'El perfil de generación se ha cargado correctamente. Ahora selecciona el CSV del perfil de precios.';
    iconData = Icons.info_outline;
    accentColor = const Color(0xFF2563EB);
    accentBg = const Color(0xFFDBEAFE);
  } else if (!genUploaded && priceUploaded) {
    title = 'Falta subir el perfil de generación';
    message =
        'El perfil de precios se ha cargado correctamente. Ahora selecciona el CSV del perfil de generación.';
    iconData = Icons.info_outline;
    accentColor = const Color(0xFF2563EB);
    accentBg = const Color(0xFFDBEAFE);
  } else {
    return;
  }

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A0F172A),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentBg,
                  ),
                  child: Center(
                    child: Icon(
                      iconData,
                      size: 48,
                      color: accentColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () {
                  Navigator.of(ctx, rootNavigator: true).pop();
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Entendido',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
