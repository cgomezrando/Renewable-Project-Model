// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

Future<void> showOpexConfigDialog(BuildContext context) async {
  const Color accentColor = Color(0xFF2563EB);
  const Color accentBg = Color(0xFFDBEAFE);
  const Color labelColor = Color(0xFF0F172A);
  const Color mutedColor = Color(0xFF64748B);
  const Color borderColor = Color(0xFFE2E8F0);
  const Color hintColor = Color(0xFF94A3B8);
  const Color errorColor = Color(0xFFDC2626);

  final currentMode =
      FFAppState().opexMode.isEmpty ? 'simple' : FFAppState().opexMode;

  String mode = currentMode;

  final simpleController = TextEditingController(
      text: currentMode == 'simple' && FFAppState().opexYear1Keur > 0
          ? FFAppState().opexYear1Keur.toString()
          : '');

  final otherController = TextEditingController(
      text: currentMode == 'bands' && FFAppState().opexYear1Keur > 0
          ? FFAppState().opexYear1Keur.toString()
          : '');

  final bandLabels = [
    'Años 1-2',
    'Años 3-5',
    'Años 6-10',
    'Años 11-15',
    'Años 16-20',
    'Años 21-25',
    'Años 26-30',
  ];
  final bandControllers = List<TextEditingController>.generate(
    7,
    (i) => TextEditingController(
      text: (currentMode == 'bands' && FFAppState().opexWtgBands.length == 7)
          ? FFAppState().opexWtgBands[i].toString()
          : '',
    ),
  );

  String? errorMsg;

  double? _parse(String s) {
    final v = s.trim().replaceAll(',', '.');
    if (v.isEmpty) return null;
    return double.tryParse(v);
  }

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: 560,
              constraints: const BoxConstraints(maxHeight: 720),
              padding: const EdgeInsets.all(28),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentBg,
                        ),
                        child: const Center(
                          child: Icon(Icons.build_outlined,
                              size: 42, color: accentColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Configurar OPEX',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Elige cómo introducir el OPEX del proyecto eólico.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: mutedColor),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _modeRadio(
                            selected: mode == 'simple',
                            label: 'Simple',
                            sub: 'OPEX año 1 con IPC',
                            onTap: () => setState(() {
                              mode = 'simple';
                              errorMsg = null;
                            }),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _modeRadio(
                            selected: mode == 'bands',
                            label: 'Por tramos',
                            sub: 'WTG por bandas + Other',
                            onTap: () => setState(() {
                              mode = 'bands';
                              errorMsg = null;
                            }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    if (mode == 'simple') ...[
                      const Text(
                        'OPEX año 1 total (k€)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: labelColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _numField(
                          simpleController, hintColor, borderColor, accentColor,
                          hint: 'Ej: 9270'),
                    ] else ...[
                      const Text(
                        'OPEX WTG por tramos (k€/año, sin IPC)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: labelColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Los valores son planos dentro de cada tramo. Tras el año 30 se aplica IPC acumulado desde el año 26.',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      const SizedBox(height: 12),
                      for (int i = 0; i < 7; i++) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                bandLabels[i],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: labelColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _numField(bandControllers[i], hintColor,
                                  borderColor, accentColor,
                                  hint: 'k€'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                      const SizedBox(height: 12),
                      const Text(
                        'Other OPEX + A&M año 1 (k€, con IPC anual)',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: labelColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _numField(
                          otherController, hintColor, borderColor, accentColor,
                          hint: 'Ej: 1200'),
                    ],
                    if (errorMsg != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline,
                                size: 16, color: errorColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(errorMsg!,
                                  style: const TextStyle(
                                      fontSize: 12, color: errorColor)),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(ctx).pop(),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    color: Color(0xFF475569),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (mode == 'simple') {
                                final v = _parse(simpleController.text);
                                if (v == null || v <= 0) {
                                  setState(() => errorMsg =
                                      'Introduce un OPEX año 1 válido (> 0)');
                                  return;
                                }
                                FFAppState().update(() {
                                  FFAppState().opexMode = 'simple';
                                  FFAppState().opexYear1Keur = v;
                                  FFAppState().opexWtgBands = [];
                                });
                              } else {
                                final bands = <double>[];
                                for (int i = 0; i < 7; i++) {
                                  final v = _parse(bandControllers[i].text);
                                  if (v == null || v < 0) {
                                    setState(() => errorMsg =
                                        'Introduce todos los tramos WTG (valor >= 0)');
                                    return;
                                  }
                                  bands.add(v);
                                }
                                final other = _parse(otherController.text);
                                if (other == null || other <= 0) {
                                  setState(() => errorMsg =
                                      'Introduce Other OPEX + A&M año 1 (> 0)');
                                  return;
                                }
                                FFAppState().update(() {
                                  FFAppState().opexMode = 'bands';
                                  FFAppState().opexWtgBands = bands;
                                  FFAppState().opexYear1Keur = other;
                                });
                              }
                              Navigator.of(ctx).pop();
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
                                  'Guardar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );

  simpleController.dispose();
  otherController.dispose();
  for (final c in bandControllers) {
    c.dispose();
  }
}

Widget _modeRadio({
  required bool selected,
  required String label,
  required String sub,
  required VoidCallback onTap,
}) {
  const Color accentColor = Color(0xFF2563EB);
  const Color accentBg = Color(0xFFDBEAFE);
  const Color labelColor = Color(0xFF0F172A);
  const Color mutedColor = Color(0xFF64748B);
  const Color borderColor = Color(0xFFE2E8F0);
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selected ? accentBg : Colors.white,
        border: Border.all(
          color: selected ? accentColor : borderColor,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: 18,
                color: selected ? accentColor : mutedColor,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: labelColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: const TextStyle(fontSize: 11, color: mutedColor),
          ),
        ],
      ),
    ),
  );
}

Widget _numField(
  TextEditingController c,
  Color hintColor,
  Color borderColor,
  Color accentColor, {
  required String hint,
}) {
  return TextField(
    controller: c,
    style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: hintColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
    ),
  );
}
