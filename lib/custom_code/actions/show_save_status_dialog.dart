// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

Future<void> showSaveStatusDialog(
  BuildContext context,
  bool success,
  String? projectName,
  String? scenarioDescription,
  DateTime? calculationDate,
) async {
  final String title;
  final String message;
  final IconData iconData;
  final Color accentColor;
  final Color accentBg;

  if (success) {
    title = 'Escenario guardado';
    final partes = <String>[];
    if (projectName != null && projectName.trim().isNotEmpty) {
      partes.add(projectName.trim());
    }
    if (scenarioDescription != null && scenarioDescription.trim().isNotEmpty) {
      partes.add(scenarioDescription.trim());
    }
    if (calculationDate != null) {
      const meses = [
        'ene',
        'feb',
        'mar',
        'abr',
        'may',
        'jun',
        'jul',
        'ago',
        'sep',
        'oct',
        'nov',
        'dic'
      ];
      final d = calculationDate;
      final hh = d.hour.toString().padLeft(2, '0');
      final mm = d.minute.toString().padLeft(2, '0');
      partes.add('${d.day} ${meses[d.month - 1]} ${d.year} · $hh:$mm');
    }
    message = partes.isEmpty
        ? 'El escenario se ha guardado correctamente.'
        : partes.join('\n');
    iconData = Icons.check_circle;
    accentColor = const Color(0xFF16A34A);
    accentBg = const Color(0xFFDCFCE7);
  } else {
    title = 'Error al guardar el escenario';
    message =
        'No se ha podido guardar el escenario. Comprueba tu conexión e inténtalo de nuevo.';
    iconData = Icons.error_outline;
    accentColor = const Color(0xFFDC2626);
    accentBg = const Color(0xFFFEE2E2);
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
