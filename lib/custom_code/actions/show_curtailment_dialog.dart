// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/app_state.dart';
import '/custom_code/actions/index.dart' as actions;

Future<bool> showCurtailmentDialog(BuildContext context) async {
  String selectedMode = FFAppState().curtailmentMode.isEmpty
      ? 'none'
      : FFAppState().curtailmentMode;
  final rateController = TextEditingController(
    text: FFAppState().curtailmentRatePct > 0
        ? FFAppState().curtailmentRatePct.toString()
        : '',
  );
  final spotGrowthController = TextEditingController(
    text: FFAppState().spotPriceGrowthPct.toString(),
  );
  bool rateError = false;
  bool ppaCoversNeg = FFAppState().ppaCoversNegativeHours;

  final Color accentColor = Color(0xFF2563EB);
  final Color accentBg = Color(0xFFDBEAFE);

  final bool? result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          // NEW: helper para saber si faltan archivos
          bool filesMissing = !FFAppState().generationFileUploaded ||
              !FFAppState().priceFileUploaded;
          bool showCloseInsteadOfCancel =
              selectedMode == 'hourly' && filesMissing;

          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: 560,
              constraints: BoxConstraints(maxHeight: 700),
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
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
                    // Icono
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentBg,
                        ),
                        child: Center(
                          child: Icon(Icons.tune, size: 48, color: accentColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Curtailment por precios negativos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Elige cómo modelar el impacto de las horas de precio negativo en el bloque merchant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Opción 1: Sin curtailment
                    _buildRadioOption(
                      setState: setState,
                      value: 'none',
                      selected: selectedMode,
                      title: 'Sin curtailment',
                      subtitle:
                          'No se aplica ningún ajuste. Todos los MWh cobran a precio pactado.',
                      onChanged: (v) => selectedMode = v,
                      accentColor: accentColor,
                    ),
                    SizedBox(height: 12),

                    // Opción 2: Modo simple
                    _buildRadioOption(
                      setState: setState,
                      value: 'simple',
                      selected: selectedMode,
                      title: 'Modo simple (curtailment fijo)',
                      subtitle:
                          'Se descuenta un % fijo del revenue merchant para reflejar horas negativas.',
                      onChanged: (v) => selectedMode = v,
                      accentColor: accentColor,
                    ),

                    if (selectedMode == 'simple') ...[
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Curtailment rate (%) *',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(height: 6),
                            TextField(
                              controller: rateController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF0F172A)),
                              decoration: InputDecoration(
                                hintText: 'Ej. 5',
                                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: rateError
                                        ? Color(0xFFDC2626)
                                        : Color(0xFFE2E8F0),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: rateError
                                        ? Color(0xFFDC2626)
                                        : Color(0xFFE2E8F0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: accentColor, width: 2),
                                ),
                                errorText: rateError
                                    ? 'Introduce un % válido entre 0 y 100'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 12),

                    // Opción 3: Modo horario
                    _buildRadioOption(
                      setState: setState,
                      value: 'hourly',
                      selected: selectedMode,
                      title: 'Modo horario (perfiles 8760)',
                      subtitle:
                          'Sube perfiles horarios de generación y precios para modelar hora a hora.',
                      onChanged: (v) => selectedMode = v,
                      accentColor: accentColor,
                    ),

                    // Panel de configuración horario
                    if (selectedMode == 'hourly') ...[
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // NEW: Mensaje si faltan archivos
                            if (filesMissing) ...[
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Color(0xFFF59E0B)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.warning_amber_rounded,
                                        size: 20, color: Color(0xFFB45309)),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        'Para usar el modo horario necesitas subir dos perfiles CSV (generación y precios).\n\nPulsa Cerrar, sube los archivos desde la sección "Perfiles horarios" en la pantalla anterior, y vuelve aquí para aplicar los cambios.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF78350F),
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                            ],

                            // Perfil generación
                            _buildFileRow(
                              label: 'Perfil de generación (MWh)',
                              uploaded: FFAppState().generationFileUploaded,
                              onDownload: () async {
                                await actions.downloadTemplate(
                                  FFAppState().templateUrlGeneration,
                                  'plantilla_generacion.csv',
                                );
                              },
                              accentColor: accentColor,
                            ),
                            SizedBox(height: 12),

                            // Perfil precios
                            _buildFileRow(
                              label: 'Perfil de precios (€/MWh)',
                              uploaded: FFAppState().priceFileUploaded,
                              onDownload: () async {
                                await actions.downloadTemplate(
                                  FFAppState().templateUrlPrices,
                                  'plantilla_precios.csv',
                                );
                              },
                              accentColor: accentColor,
                            ),
                            SizedBox(height: 16),
                            Divider(color: Color(0xFFE2E8F0), height: 1),
                            SizedBox(height: 16),

                            // Toggle PPA
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'El PPA cobra en horas negativas',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        'Activo si tu PPA es "as-produced" tradicional',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: ppaCoversNeg,
                                  onChanged: (v) =>
                                      setState(() => ppaCoversNeg = v),
                                  activeColor: accentColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 12),

                            // Spot growth
                            Text(
                              'Crecimiento anual precio spot (%)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            SizedBox(height: 6),
                            TextField(
                              controller: spotGrowthController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF0F172A)),
                              decoration: InputDecoration(
                                hintText: 'Ej. 1.5',
                                hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: accentColor, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 24),

                    // Botones
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (showCloseInsteadOfCancel) {
                                FFAppState().update(() {
                                  FFAppState().curtailmentMode = 'hourly';
                                });
                              }

                              Navigator.of(ctx, rootNavigator: true).pop(false);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Color(0xFFE2E8F0)),
                              ),
                              child: Center(
                                // NEW: cambia texto según contexto
                                child: Text(
                                  showCloseInsteadOfCancel
                                      ? 'Cerrar'
                                      : 'Cancelar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // Validar
                              if (selectedMode == 'simple') {
                                double? rate = double.tryParse(
                                    rateController.text.replaceAll(',', '.'));
                                if (rate == null || rate < 0 || rate > 100) {
                                  setState(() => rateError = true);
                                  return;
                                }
                                FFAppState().curtailmentRatePct = rate;
                              } else {
                                FFAppState().curtailmentRatePct = 0.0;
                              }
                              if (selectedMode == 'hourly') {
                                if (!FFAppState().generationFileUploaded ||
                                    !FFAppState().priceFileUploaded) {
                                  ScaffoldMessenger.of(ctx).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Necesitas subir los dos archivos CSV antes de aplicar el modo horario'),
                                      backgroundColor: Color(0xFFDC2626),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  return;
                                }
                                double? growth = double.tryParse(
                                    spotGrowthController.text
                                        .replaceAll(',', '.'));
                                FFAppState().spotPriceGrowthPct = growth ?? 0.0;
                                FFAppState().ppaCoversNegativeHours =
                                    ppaCoversNeg;
                              }
                              FFAppState().curtailmentMode = selectedMode;
                              Navigator.of(ctx, rootNavigator: true).pop(true);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Aplicar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
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

  return result ?? false;
}

Widget _buildRadioOption({
  required StateSetter setState,
  required String value,
  required String selected,
  required String title,
  required String subtitle,
  required Function(String) onChanged,
  required Color accentColor,
}) {
  final bool isSelected = selected == value;
  return InkWell(
    onTap: () => setState(() => onChanged(value)),
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFDBEAFE).withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? accentColor : Color(0xFFE2E8F0),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? accentColor : Color(0xFFCBD5E1),
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: accentColor),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFileRow({
  required String label,
  required bool uploaded,
  required VoidCallback onDownload,
  required Color accentColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
          InkWell(
            onTap: onDownload,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download, size: 14, color: accentColor),
                SizedBox(width: 4),
                Text(
                  'Descargar plantilla',
                  style: TextStyle(
                    fontSize: 12,
                    color: accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 6),
      Row(
        children: [
          Icon(
            uploaded ? Icons.check_circle : Icons.upload_file,
            size: 16,
            color: uploaded ? Color(0xFF16A34A) : Color(0xFF94A3B8),
          ),
          SizedBox(width: 8),
          Text(
            uploaded
                ? 'Archivo cargado (8760 valores)'
                : 'Ningún archivo cargado',
            style: TextStyle(
              fontSize: 12,
              color: uploaded ? Color(0xFF16A34A) : Color(0xFF64748B),
            ),
          ),
        ],
      ),
    ],
  );
}
