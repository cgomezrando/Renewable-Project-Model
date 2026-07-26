// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

import 'dart:convert';

Future<void> showGoalSeekDialog(BuildContext context) async {
  final Color accentColor = const Color(0xFF2563EB);
  final Color accentBg = const Color(0xFFDBEAFE);
  final Color labelColor = const Color(0xFF0F172A);
  final Color mutedColor = const Color(0xFF64748B);
  final Color borderColor = const Color(0xFFE2E8F0);
  final Color hintColor = const Color(0xFF94A3B8);
  final Color successBg = const Color(0xFFDCFCE7);
  final Color successColor = const Color(0xFF16A34A);
  final Color errorBg = const Color(0xFFFEE2E2);
  final Color errorColor = const Color(0xFFDC2626);

  final valueController = TextEditingController(text: '8');
  String target = 'project_irr';
  String move = 'ppa';
  bool loading = false;
  Map<String, dynamic>? result;
  String? errorMessage;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          Future<void> _calculate() async {
            final rawValue = valueController.text.trim().replaceAll(',', '.');
            final parsed = double.tryParse(rawValue);
            if (parsed == null || parsed <= 0) {
              setState(() {
                errorMessage = 'Introduce un IRR objetivo válido (> 0)';
                result = null;
              });
              return;
            }

            setState(() {
              loading = true;
              errorMessage = null;
              result = null;
            });

            final resp = await runGoalSeek(target, parsed, move);
            Map<String, dynamic>? parsedResp;
            try {
              parsedResp = jsonDecode(resp ?? '') as Map<String, dynamic>;
            } catch (_) {
              parsedResp = null;
            }

            setState(() {
              loading = false;
              result = parsedResp;
              if (parsedResp == null) {
                errorMessage =
                    'No se pudo interpretar la respuesta del servidor';
              }
            });
          }

          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: 520,
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
              child: SingleChildScrollView(
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
                          child: Icon(Icons.track_changes,
                              size: 48, color: accentColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Análisis de sensibilidad',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Encuentra el precio PPA mínimo o el CAPEX máximo que hace tocar la rentabilidad objetivo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: mutedColor,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Objetivo de rentabilidad',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      options: const [
                        MapEntry('project_irr', 'Project IRR'),
                        MapEntry('equity_irr', 'Equity IRR'),
                      ],
                      selected: target,
                      onSelect: (v) => setState(() {
                        target = v;
                        result = null;
                      }),
                      accentColor: accentColor,
                      accentBg: accentBg,
                      borderColor: borderColor,
                      labelColor: labelColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'IRR mínimo deseado (%)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: valueController,
                      style: TextStyle(fontSize: 14, color: labelColor),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Ej: 8',
                        hintStyle: TextStyle(color: hintColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: accentColor, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Variable a resolver',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildToggleRow(
                      options: const [
                        MapEntry('ppa', 'Precio PPA mínimo'),
                        MapEntry('capex_total', 'CAPEX máximo'),
                      ],
                      selected: move,
                      onSelect: (v) => setState(() {
                        move = v;
                        result = null;
                      }),
                      accentColor: accentColor,
                      accentBg: accentBg,
                      borderColor: borderColor,
                      labelColor: labelColor,
                    ),
                    if (errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: errorBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                size: 18, color: errorColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style:
                                    TextStyle(fontSize: 13, color: errorColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (result != null) ...[
                      const SizedBox(height: 20),
                      _buildResultCard(
                        result: result!,
                        move: move,
                        target: target,
                        successBg: successBg,
                        successColor: successColor,
                        errorBg: errorBg,
                        errorColor: errorColor,
                        labelColor: labelColor,
                        mutedColor: mutedColor,
                      ),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:
                                loading ? null : () => Navigator.of(ctx).pop(),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'Cerrar',
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
                            onTap: loading ? null : _calculate,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: loading ? mutedColor : accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: loading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Calcular',
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

  valueController.dispose();
}

Widget _buildToggleRow({
  required List<MapEntry<String, String>> options,
  required String selected,
  required ValueChanged<String> onSelect,
  required Color accentColor,
  required Color accentBg,
  required Color borderColor,
  required Color labelColor,
}) {
  return Row(
    children: [
      for (int i = 0; i < options.length; i++) ...[
        Expanded(
          child: InkWell(
            onTap: () => onSelect(options[i].key),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selected == options[i].key ? accentBg : Colors.white,
                border: Border.all(
                  color: selected == options[i].key ? accentColor : borderColor,
                  width: selected == options[i].key ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  options[i].value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected == options[i].key
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: labelColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (i < options.length - 1) const SizedBox(width: 8),
      ],
    ],
  );
}

Widget _buildResultCard({
  required Map<String, dynamic> result,
  required String move,
  required String target,
  required Color successBg,
  required Color successColor,
  required Color errorBg,
  required Color errorColor,
  required Color labelColor,
  required Color mutedColor,
}) {
  final bool found = result['found'] == true;
  final Color bg = found ? successBg : errorBg;
  final Color acc = found ? successColor : errorColor;

  if (!found) {
    final reason = result['reason']?.toString() ??
        'No se pudo alcanzar el objetivo en el rango razonable.';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 20, color: acc),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No factible',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: acc,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reason,
                  style: TextStyle(fontSize: 12, color: labelColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final String mainLabel;
  final String mainValue;
  if (move == 'ppa') {
    final ppa = (result['ppa_price_eur_mwh'] ?? 0).toDouble();
    mainLabel = 'Precio PPA mínimo';
    mainValue = '${ppa.toStringAsFixed(2).replaceAll('.', ',')} €/MWh';
  } else {
    final capex = (result['capex_indexed_total_keur'] ?? 0).toDouble();
    mainLabel = 'CAPEX indexado máximo';
    mainValue = '${_fmtThousand(capex)} k€';
  }

  final achieved = (result['achieved_irr_pct'] ?? 0).toDouble();
  final targetLabel = target == 'project_irr' ? 'Project IRR' : 'Equity IRR';

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, size: 20, color: acc),
            const SizedBox(width: 8),
            Text(
              'Resultado',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: acc,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          mainLabel,
          style: TextStyle(fontSize: 12, color: mutedColor),
        ),
        const SizedBox(height: 2),
        Text(
          mainValue,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '$targetLabel alcanzado: ${achieved.toStringAsFixed(2).replaceAll('.', ',')} %',
          style: TextStyle(fontSize: 12, color: mutedColor),
        ),
      ],
    ),
  );
}

String _fmtThousand(double v) {
  final neg = v < 0;
  final abs = v.abs();
  final s = abs.toStringAsFixed(0);
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return '${neg ? '-' : ''}${buf.toString()}';
}
