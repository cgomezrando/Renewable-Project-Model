// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

Future<bool> showNewProjectDialog(BuildContext context) async {
  final Color accentColor = const Color(0xFF2563EB);
  final Color accentBg = const Color(0xFFDBEAFE);
  final Color hintColor = const Color(0xFF94A3B8);
  final Color labelColor = const Color(0xFF0F172A);
  final Color errorColor = const Color(0xFFDC2626);

  final bool isSolar = FFAppState().technology.toLowerCase() == 'solar';

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final acController = TextEditingController();
  final dcController = TextEditingController();
  DateTime? socDate;
  DateTime? codDate;

  bool nameError = false;
  bool descError = false;
  bool acError = false;
  bool dcError = false;
  bool socError = false;
  bool codError = false;

  final result = await showDialog<bool>(
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
              constraints: const BoxConstraints(maxHeight: 740),
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
                          child: Icon(Icons.add_circle_outline,
                              size: 48, color: accentColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Nuevo proyecto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Completa la información para iniciar el análisis financiero.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Nombre del proyecto *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      style: TextStyle(fontSize: 14, color: labelColor),
                      onChanged: (_) {
                        if (nameError) setState(() => nameError = false);
                      },
                      decoration: InputDecoration(
                        hintText: 'Ej: Parque Norte',
                        hintStyle: TextStyle(color: hintColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: nameError
                                  ? errorColor
                                  : const Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: nameError ? errorColor : accentColor,
                              width: 2),
                        ),
                      ),
                    ),
                    if (nameError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Introduce un nombre',
                            style: TextStyle(fontSize: 12, color: errorColor)),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Descripción *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descController,
                      style: TextStyle(fontSize: 14, color: labelColor),
                      maxLines: 2,
                      onChanged: (_) {
                        if (descError) setState(() => descError = false);
                      },
                      decoration: InputDecoration(
                        hintText: 'Ej: Caso base con curtailment horario',
                        hintStyle: TextStyle(color: hintColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: descError
                                  ? errorColor
                                  : const Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: descError ? errorColor : accentColor,
                              width: 2),
                        ),
                      ),
                    ),
                    if (descError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Introduce una descripción',
                            style: TextStyle(fontSize: 12, color: errorColor)),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Potencia nominal AC (MW) *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: acController,
                      style: TextStyle(fontSize: 14, color: labelColor),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) {
                        if (acError) setState(() => acError = false);
                      },
                      decoration: InputDecoration(
                        hintText: 'Ej: 100',
                        hintStyle: TextStyle(color: hintColor),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: acError
                                  ? errorColor
                                  : const Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: acError ? errorColor : accentColor,
                              width: 2),
                        ),
                      ),
                    ),
                    if (acError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Introduce la potencia nominal AC',
                            style: TextStyle(fontSize: 12, color: errorColor)),
                      ),
                    if (isSolar) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Potencia pico DC (MWp) *',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: labelColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: dcController,
                        style: TextStyle(fontSize: 14, color: labelColor),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (_) {
                          if (dcError) setState(() => dcError = false);
                        },
                        decoration: InputDecoration(
                          hintText: 'Ej: 130',
                          hintStyle: TextStyle(color: hintColor),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: dcError
                                    ? errorColor
                                    : const Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: dcError ? errorColor : accentColor,
                                width: 2),
                          ),
                        ),
                      ),
                      if (dcError)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text('Introduce la potencia pico DC',
                              style:
                                  TextStyle(fontSize: 12, color: errorColor)),
                        ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Fecha de inicio de construcción (SOC) *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate: socDate ??
                              DateTime.now().add(const Duration(days: 180)),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now()
                              .add(const Duration(days: 365 * 10)),
                        );
                        if (picked != null) {
                          setState(() {
                            socDate = picked;
                            socError = false;
                            if (codDate != null && !codDate!.isAfter(picked)) {
                              codDate = null;
                            }
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: socError
                                  ? errorColor
                                  : const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              socDate != null
                                  ? '${socDate!.day.toString().padLeft(2, '0')}/${socDate!.month.toString().padLeft(2, '0')}/${socDate!.year}'
                                  : 'Selecciona fecha',
                              style: TextStyle(
                                fontSize: 14,
                                color: socDate != null ? labelColor : hintColor,
                              ),
                            ),
                            Icon(Icons.calendar_today_outlined,
                                size: 18, color: accentColor),
                          ],
                        ),
                      ),
                    ),
                    if (socError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Selecciona la fecha de SOC',
                            style: TextStyle(fontSize: 12, color: errorColor)),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Fecha de operación comercial (COD) *',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: labelColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final base = socDate ??
                            DateTime.now().add(const Duration(days: 180));
                        final picked = await showDatePicker(
                          context: ctx,
                          initialDate:
                              codDate ?? base.add(const Duration(days: 365)),
                          firstDate: socDate != null
                              ? socDate!.add(const Duration(days: 1))
                              : DateTime.now(),
                          lastDate: DateTime.now()
                              .add(const Duration(days: 365 * 15)),
                        );
                        if (picked != null) {
                          setState(() {
                            codDate = picked;
                            codError = false;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: codError
                                  ? errorColor
                                  : const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              codDate != null
                                  ? '${codDate!.day.toString().padLeft(2, '0')}/${codDate!.month.toString().padLeft(2, '0')}/${codDate!.year}'
                                  : 'Selecciona fecha',
                              style: TextStyle(
                                fontSize: 14,
                                color: codDate != null ? labelColor : hintColor,
                              ),
                            ),
                            Icon(Icons.calendar_today_outlined,
                                size: 18, color: accentColor),
                          ],
                        ),
                      ),
                    ),
                    if (codError)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text('Selecciona la fecha de COD',
                            style: TextStyle(fontSize: 12, color: errorColor)),
                      ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(ctx).pop(false),
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
                              final nameEmpty =
                                  nameController.text.trim().isEmpty;
                              final descEmpty =
                                  descController.text.trim().isEmpty;
                              final socEmpty = socDate == null;
                              final codEmpty = codDate == null;

                              final acRaw =
                                  acController.text.trim().replaceAll(',', '.');
                              final acValue = double.tryParse(acRaw);
                              final acInvalid = acValue == null || acValue <= 0;

                              double? dcValue;
                              bool dcInvalid = false;
                              if (isSolar) {
                                final dcRaw = dcController.text
                                    .trim()
                                    .replaceAll(',', '.');
                                dcValue = double.tryParse(dcRaw);
                                dcInvalid = dcValue == null || dcValue <= 0;
                              }

                              if (nameEmpty ||
                                  descEmpty ||
                                  acInvalid ||
                                  socEmpty ||
                                  codEmpty ||
                                  dcInvalid) {
                                setState(() {
                                  nameError = nameEmpty;
                                  descError = descEmpty;
                                  acError = acInvalid;
                                  socError = socEmpty;
                                  codError = codEmpty;
                                  dcError = dcInvalid;
                                });
                                return;
                              }

                              FFAppState().update(() {
                                FFAppState().projectName =
                                    nameController.text.trim();
                                FFAppState().projectDescription =
                                    descController.text.trim();
                                FFAppState().installedMw = acValue!;
                                FFAppState().socDate = socDate;
                                FFAppState().codDate = codDate;
                                if (isSolar && dcValue != null) {
                                  FFAppState().installedDCMw = dcValue;
                                }
                              });

                              Navigator.of(ctx).pop(true);
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
                                  'Continuar',
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

  nameController.dispose();
  descController.dispose();
  acController.dispose();
  dcController.dispose();

  return result ?? false;
}
