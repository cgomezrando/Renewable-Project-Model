// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/app_state.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

Future<bool> showCurtailmentDialog(BuildContext context) async {
  const Color accentColor = Color(0xFF2563EB);
  const Color accentBg = Color(0xFFDBEAFE);
  const Color labelColor = Color(0xFF0F172A);
  const Color mutedColor = Color(0xFF64748B);
  const Color borderColor = Color(0xFFE2E8F0);
  const Color hintColor = Color(0xFF94A3B8);
  const Color errorColor = Color(0xFFDC2626);
  const Color successColor = Color(0xFF16A34A);

  String merchantMode =
      FFAppState().merchantMode.isEmpty ? 'simple' : FFAppState().merchantMode;

  String priceCurveMode = FFAppState().priceCurveMode.isEmpty
      ? 'quick'
      : FFAppState().priceCurveMode;
  final priceYear1Controller = TextEditingController(
      text: FFAppState().priceYear1 > 0
          ? FFAppState().priceYear1.toString()
          : '');
  final priceGrowthController =
      TextEditingController(text: FFAppState().priceGrowthPct.toString());

  String captureRateMode = FFAppState().captureRateMode.isEmpty
      ? 'constant'
      : FFAppState().captureRateMode;
  final captureConstantController = TextEditingController(
      text: FFAppState().captureRateConstant > 0
          ? FFAppState().captureRateConstant.toString()
          : '');

  final curtailTecnicoController =
      TextEditingController(text: FFAppState().curtailTecnicoPct.toString());

  String curtailEconomicoMode = FFAppState().curtailEconomicoMode.isEmpty
      ? 'manual'
      : FFAppState().curtailEconomicoMode;
  final curtailEconomicoController =
      TextEditingController(text: FFAppState().curtailEconomicoPct.toString());

  String? errorMsg;

  Future<bool> _pickAndParseAnnual(
      String targetKey, int rows, StateSetter setState) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return false;
      final bytes = result.files.first.bytes;
      if (bytes == null || bytes.isEmpty) return false;
      final content = utf8.decode(bytes, allowMalformed: true);
      if (content.isEmpty) return false;
      final ok = await parseCsvAnnual(content, targetKey, rows);
      if (ok) setState(() {});
      return ok;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _pickAndParse8760(String target, StateSetter setState) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return false;
      final bytes = result.files.first.bytes;
      if (bytes == null || bytes.isEmpty) return false;
      final content = utf8.decode(bytes, allowMalformed: true);
      if (content.isEmpty) return false;

      final lines = content
          .split(RegExp(r'\r?\n'))
          .where((l) => l.trim().isNotEmpty)
          .toList();
      if (lines.isEmpty) return false;

      final values = <double>[];
      final firstCells = lines[0].split(RegExp(r'[,;\t]'));
      final testVal = firstCells.last.trim().replaceAll(',', '.');
      final startIdx = (double.tryParse(testVal) == null) ? 1 : 0;

      for (int i = startIdx; i < lines.length; i++) {
        final cells = lines[i].split(RegExp(r'[,;\t]'));
        if (cells.isEmpty) continue;
        final raw = cells.last.trim().replaceAll(',', '.');
        final v = double.tryParse(raw);
        if (v != null) values.add(v);
      }

      if (values.length < 8760) return false;

      FFAppState().update(() {
        if (target == 'generation') {
          FFAppState().generationProfile = values.sublist(0, 8760);
          FFAppState().generationFileUploaded = true;
        } else {
          FFAppState().priceProfile = values.sublist(0, 8760);
          FFAppState().priceFileUploaded = true;
        }
      });
      setState(() {});
      return true;
    } catch (e) {
      return false;
    }
  }

  final bool? dialogResult = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          final proj = FFAppState().projectLifeYears > 0
              ? FFAppState().projectLifeYears
              : 30;

          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              width: 620,
              constraints: BoxConstraints(maxHeight: 800),
              padding: EdgeInsets.all(28),
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
                    Center(
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentBg,
                        ),
                        child: Center(
                          child: Icon(Icons.tune, size: 42, color: accentColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Configurar precios e ingresos',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: labelColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Precio merchant, capture rate y curtailment económico del PPA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13, color: mutedColor, height: 1.4),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _modeCard(
                            selected: merchantMode == 'simple',
                            title: 'Simple',
                            sub: 'Curva anual + Capture rate',
                            onTap: () => setState(() {
                              merchantMode = 'simple';
                              errorMsg = null;
                            }),
                            accent: accentColor,
                            accentBg: accentBg,
                            border: borderColor,
                            label: labelColor,
                            muted: mutedColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _modeCard(
                            selected: merchantMode == 'detailed',
                            title: 'Detallado',
                            sub: 'Precio capturado externo',
                            onTap: () => setState(() {
                              merchantMode = 'detailed';
                              errorMsg = null;
                            }),
                            accent: accentColor,
                            accentBg: accentBg,
                            border: borderColor,
                            label: labelColor,
                            muted: mutedColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _modeCard(
                            selected: merchantMode == 'complex',
                            title: 'Complejo',
                            sub: 'Curva horaria 30 años',
                            onTap: () => setState(() {
                              merchantMode = 'complex';
                              errorMsg = null;
                            }),
                            accent: accentColor,
                            accentBg: accentBg,
                            border: borderColor,
                            label: labelColor,
                            muted: mutedColor,
                            disabled: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (merchantMode == 'simple') ...[
                      _sectionTitle('Curva de precios de mercado', labelColor),
                      SizedBox(height: 10),
                      _subToggle(
                        selected: priceCurveMode,
                        options: [
                          MapEntry('quick', 'Rápido'),
                          MapEntry('csv', 'Desde CSV'),
                        ],
                        onChange: (v) => setState(() => priceCurveMode = v),
                        accent: accentColor,
                        accentBg: accentBg,
                        border: borderColor,
                        label: labelColor,
                      ),
                      SizedBox(height: 12),
                      if (priceCurveMode == 'quick') ...[
                        _labelText('Precio año 1 (€/MWh)', labelColor),
                        SizedBox(height: 6),
                        _numField(priceYear1Controller, 'Ej. 65', hintColor,
                            borderColor, accentColor, labelColor),
                        SizedBox(height: 10),
                        _labelText('Crecimiento anual (%)', labelColor),
                        SizedBox(height: 6),
                        _numField(priceGrowthController, 'Ej. 1.5', hintColor,
                            borderColor, accentColor, labelColor),
                      ] else ...[
                        _fileUploadBlock(
                          title: 'Curva de precios anual ($proj valores)',
                          uploaded:
                              FFAppState().annualMarketPrices.length >= proj,
                          templateUrl: FFAppState().templateUrlMarketPrices,
                          templateFileName: 'plantilla_precios_mercado.csv',
                          countText:
                              '${FFAppState().annualMarketPrices.length} valores cargados',
                          onUpload: () => _pickAndParseAnnual(
                              'marketPrices', proj, setState),
                          accent: accentColor,
                          titleColor: labelColor,
                          muted: mutedColor,
                          success: successColor,
                        ),
                      ],
                      SizedBox(height: 20),
                      _sectionTitle('Capture Rate', labelColor),
                      SizedBox(height: 10),
                      _subToggle(
                        selected: captureRateMode,
                        options: [
                          MapEntry('constant', 'Constante'),
                          MapEntry('manual', 'Manual (CSV)'),
                        ],
                        onChange: (v) => setState(() => captureRateMode = v),
                        accent: accentColor,
                        accentBg: accentBg,
                        border: borderColor,
                        label: labelColor,
                      ),
                      SizedBox(height: 12),
                      if (captureRateMode == 'constant') ...[
                        _labelText('Capture Rate (%)', labelColor),
                        SizedBox(height: 6),
                        _numField(captureConstantController, 'Ej. 95',
                            hintColor, borderColor, accentColor, labelColor),
                      ] else ...[
                        _fileUploadBlock(
                          title: 'Capture Rates anuales ($proj valores)',
                          uploaded:
                              FFAppState().annualCaptureRates.length >= proj,
                          templateUrl: FFAppState().templateUrlCaptureRates,
                          templateFileName: 'plantilla_capture_rates.csv',
                          countText:
                              '${FFAppState().annualCaptureRates.length} valores cargados',
                          onUpload: () => _pickAndParseAnnual(
                              'captureRates', proj, setState),
                          accent: accentColor,
                          titleColor: labelColor,
                          muted: mutedColor,
                          success: successColor,
                        ),
                      ],
                    ],
                    if (merchantMode == 'detailed') ...[
                      _sectionTitle('Curva de precios capturados', labelColor),
                      SizedBox(height: 4),
                      Text(
                        'Precio anual ya post-curtailment económico, obtenido de proveedores externos (Aurora, AFRY, etc.).',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      SizedBox(height: 10),
                      _fileUploadBlock(
                        title: 'Precios capturados anuales ($proj valores)',
                        uploaded:
                            FFAppState().annualCapturedPrices.length >= proj,
                        templateUrl: FFAppState().templateUrlCapturedPrices,
                        templateFileName: 'plantilla_precios_capturados.csv',
                        countText:
                            '${FFAppState().annualCapturedPrices.length} valores cargados',
                        onUpload: () => _pickAndParseAnnual(
                            'capturedPrices', proj, setState),
                        accent: accentColor,
                        titleColor: labelColor,
                        muted: mutedColor,
                        success: successColor,
                      ),
                      SizedBox(height: 16),
                      _sectionTitle('Perfil horario de generación', labelColor),
                      SizedBox(height: 4),
                      Text(
                        'Solo se usa para producción mensual/estacional. NO afecta al ingreso agregado.',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      SizedBox(height: 10),
                      _fileUploadBlock(
                        title: 'Perfil de generación (8760 valores)',
                        uploaded: FFAppState().generationFileUploaded,
                        templateUrl: FFAppState().templateUrlGeneration,
                        templateFileName: 'plantilla_generacion.csv',
                        countText:
                            '${FFAppState().generationProfile.length} valores cargados',
                        onUpload: () =>
                            _pickAndParse8760('generation', setState),
                        accent: accentColor,
                        titleColor: labelColor,
                        muted: mutedColor,
                        success: successColor,
                      ),
                      SizedBox(height: 16),
                      _labelText('Curtailment técnico (%)', labelColor),
                      SizedBox(height: 4),
                      Text(
                        'Pérdidas por disponibilidad no capturadas en el capacity factor. Default 0.',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      SizedBox(height: 8),
                      _numField(curtailTecnicoController, 'Ej. 1.5', hintColor,
                          borderColor, accentColor, labelColor),
                    ],
                    if (merchantMode == 'complex') ...[
                      _sectionTitle('Perfil de generación', labelColor),
                      SizedBox(height: 4),
                      Text(
                        'Perfil 8760 base (año 1). La degradación anual se aplica automáticamente.',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      SizedBox(height: 10),
                      _fileUploadBlock(
                        title: 'Perfil de generación (8760 valores)',
                        uploaded: FFAppState().generationFileUploaded,
                        templateUrl: FFAppState().templateUrlGeneration,
                        templateFileName: 'plantilla_generacion.csv',
                        countText:
                            '${FFAppState().generationProfile.length} valores cargados',
                        onUpload: () =>
                            _pickAndParse8760('generation', setState),
                        accent: accentColor,
                        titleColor: labelColor,
                        muted: mutedColor,
                        success: successColor,
                      ),
                      SizedBox(height: 16),
                      _sectionTitle('Curva horaria de precios', labelColor),
                      SizedBox(height: 4),
                      Text(
                        'Matriz CSV: 8760 filas × N columnas (una columna por año del proyecto).',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      SizedBox(height: 10),
                      _fileUploadBlock(
                        title: 'Matriz de precios horarios',
                        uploaded: FFAppState().hourlyPricesCsv.isNotEmpty,
                        templateUrl: '',
                        templateFileName: '',
                        countText: 'Archivo subido a Storage',
                        onUpload: () async {
                          final ok = await loadHourlyPricesCsv();
                          if (ok) setState(() {});
                          return ok;
                        },
                        accent: accentColor,
                        titleColor: labelColor,
                        muted: mutedColor,
                        success: successColor,
                      ),
                    ],
                    if (merchantMode != 'complex') ...[
                      SizedBox(height: 24),
                      Divider(color: borderColor),
                      SizedBox(height: 16),
                      _sectionTitle(
                          'Curtailment económico del PPA', labelColor),
                      SizedBox(height: 4),
                      Text(
                        '% de energía PPA no cobrada (horas con precio spot negativo).',
                        style: TextStyle(fontSize: 11, color: mutedColor),
                      ),
                      SizedBox(height: 10),
                      _subToggle(
                        selected: curtailEconomicoMode,
                        options: [
                          MapEntry('manual', 'Plano'),
                          MapEntry('auto', 'Calcular desde 8760'),
                        ],
                        onChange: (v) => setState(() {
                          curtailEconomicoMode = v;
                          errorMsg = null;
                        }),
                        accent: accentColor,
                        accentBg: accentBg,
                        border: borderColor,
                        label: labelColor,
                      ),
                      SizedBox(height: 12),
                      if (curtailEconomicoMode == 'manual') ...[
                        _labelText('Curtailment económico PPA (%)', labelColor),
                        SizedBox(height: 6),
                        _numField(curtailEconomicoController, 'Ej. 3',
                            hintColor, borderColor, accentColor, labelColor),
                      ] else ...[
                        _fileUploadBlock(
                          title: 'Perfil de generación (8760 valores)',
                          uploaded: FFAppState().generationFileUploaded,
                          templateUrl: FFAppState().templateUrlGeneration,
                          templateFileName: 'plantilla_generacion.csv',
                          countText:
                              '${FFAppState().generationProfile.length} valores cargados',
                          onUpload: () =>
                              _pickAndParse8760('generation', setState),
                          accent: accentColor,
                          titleColor: labelColor,
                          muted: mutedColor,
                          success: successColor,
                        ),
                        SizedBox(height: 10),
                        _fileUploadBlock(
                          title: 'Perfil de precios (8760 valores)',
                          uploaded: FFAppState().priceFileUploaded,
                          templateUrl: FFAppState().templateUrlPrices,
                          templateFileName: 'plantilla_precios.csv',
                          countText:
                              '${FFAppState().priceProfile.length} valores cargados',
                          onUpload: () => _pickAndParse8760('prices', setState),
                          accent: accentColor,
                          titleColor: labelColor,
                          muted: mutedColor,
                          success: successColor,
                        ),
                        SizedBox(height: 10),
                        if (FFAppState().generationFileUploaded &&
                            FFAppState().priceFileUploaded) ...[
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0FDF4),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF16A34A)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calculate_outlined,
                                    size: 18, color: successColor),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Curtailment calculado: ${functions.calculateCurtailEconFrom8760(FFAppState().generationProfile, FFAppState().priceProfile).toStringAsFixed(2)}%',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline,
                                    size: 16, color: mutedColor),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Sube ambos perfiles para calcular el curtailment automáticamente.',
                                    style: TextStyle(
                                        fontSize: 12, color: mutedColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ],
                    if (errorMsg != null) ...[
                      SizedBox(height: 14),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline,
                                size: 16, color: errorColor),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(errorMsg!,
                                  style: TextStyle(
                                      fontSize: 12, color: errorColor)),
                            ),
                          ],
                        ),
                      ),
                    ],
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(ctx, rootNavigator: true)
                                .pop(false),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
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
                        SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (merchantMode == 'complex') {
                                if (!FFAppState().generationFileUploaded) {
                                  setState(() => errorMsg =
                                      'Sube el perfil de generación 8760.');
                                  return;
                                }
                                if (FFAppState().hourlyPricesCsv.isEmpty) {
                                  setState(() => errorMsg =
                                      'Sube la matriz de precios horarios.');
                                  return;
                                }
                              }

                              if (merchantMode == 'simple') {
                                if (priceCurveMode == 'quick') {
                                  final p1 = double.tryParse(
                                      priceYear1Controller.text
                                          .replaceAll(',', '.'));
                                  final g = double.tryParse(
                                      priceGrowthController.text
                                          .replaceAll(',', '.'));
                                  if (p1 == null || p1 <= 0) {
                                    setState(() => errorMsg =
                                        'Precio año 1 inválido (> 0)');
                                    return;
                                  }
                                  final growth = g ?? 0.0;
                                  final curve = <double>[];
                                  for (int y = 0; y < proj; y++) {
                                    curve.add(p1 * _pow(1 + growth / 100, y));
                                  }
                                  FFAppState().priceYear1 = p1;
                                  FFAppState().priceGrowthPct = growth;
                                  FFAppState().annualMarketPrices = curve;
                                } else {
                                  if (FFAppState().annualMarketPrices.length <
                                      proj) {
                                    setState(() => errorMsg =
                                        'Sube el CSV de precios de mercado ($proj valores).');
                                    return;
                                  }
                                }

                                if (captureRateMode == 'constant') {
                                  final c = double.tryParse(
                                      captureConstantController.text
                                          .replaceAll(',', '.'));
                                  if (c == null || c <= 0 || c > 100) {
                                    setState(() => errorMsg =
                                        'Capture rate inválido (0-100).');
                                    return;
                                  }
                                  FFAppState().captureRateConstant = c;
                                  FFAppState().annualCaptureRates =
                                      List<double>.filled(proj, c);
                                } else {
                                  if (FFAppState().annualCaptureRates.length <
                                      proj) {
                                    setState(() => errorMsg =
                                        'Sube el CSV de capture rates ($proj valores).');
                                    return;
                                  }
                                }

                                FFAppState().priceCurveMode = priceCurveMode;
                                FFAppState().captureRateMode = captureRateMode;
                              }

                              if (merchantMode == 'detailed') {
                                if (FFAppState().annualCapturedPrices.length <
                                    proj) {
                                  setState(() => errorMsg =
                                      'Sube el CSV de precios capturados ($proj valores).');
                                  return;
                                }
                                final ct = double.tryParse(
                                    curtailTecnicoController.text
                                        .replaceAll(',', '.'));
                                FFAppState().curtailTecnicoPct = ct ?? 0.0;
                              }

                              if (curtailEconomicoMode == 'manual') {
                                final ce = double.tryParse(
                                    curtailEconomicoController.text
                                        .replaceAll(',', '.'));
                                if (ce == null || ce < 0 || ce > 100) {
                                  setState(() => errorMsg =
                                      'Curtailment económico inválido (0-100).');
                                  return;
                                }
                                FFAppState().curtailEconomicoPct = ce;
                              } else {
                                if (!FFAppState().generationFileUploaded ||
                                    !FFAppState().priceFileUploaded) {
                                  setState(() => errorMsg =
                                      'Sube ambos perfiles 8760 para el cálculo automático.');
                                  return;
                                }
                                final calc =
                                    functions.calculateCurtailEconFrom8760(
                                        FFAppState().generationProfile,
                                        FFAppState().priceProfile);
                                FFAppState().curtailEconomicoPct = calc;
                              }
                              FFAppState().curtailEconomicoMode =
                                  curtailEconomicoMode;

                              FFAppState().merchantMode = merchantMode;
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

  priceYear1Controller.dispose();
  priceGrowthController.dispose();
  captureConstantController.dispose();
  curtailTecnicoController.dispose();
  curtailEconomicoController.dispose();

  return dialogResult ?? false;
}

double _pow(double base, int exp) {
  double r = 1.0;
  for (int i = 0; i < exp; i++) r *= base;
  return r;
}

Widget _modeCard({
  required bool selected,
  required String title,
  required String sub,
  required VoidCallback onTap,
  required Color accent,
  required Color accentBg,
  required Color border,
  required Color label,
  required Color muted,
  bool disabled = false,
}) {
  return InkWell(
    onTap: disabled ? null : onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            disabled ? Color(0xFFF8FAFC) : (selected ? accentBg : Colors.white),
        border: Border.all(
          color: selected ? accent : border,
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
                size: 16,
                color: disabled ? muted : (selected ? accent : muted),
              ),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: disabled ? muted : label,
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(sub, style: TextStyle(fontSize: 10, color: muted, height: 1.2)),
        ],
      ),
    ),
  );
}

Widget _sectionTitle(String txt, Color clr) {
  return Text(
    txt,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: clr,
    ),
  );
}

Widget _labelText(String txt, Color clr) {
  return Text(
    txt,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: clr,
    ),
  );
}

Widget _subToggle({
  required String selected,
  required List<MapEntry<String, String>> options,
  required ValueChanged<String> onChange,
  required Color accent,
  required Color accentBg,
  required Color border,
  required Color label,
}) {
  return Row(
    children: [
      for (int i = 0; i < options.length; i++) ...[
        Expanded(
          child: InkWell(
            onTap: () => onChange(options[i].key),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selected == options[i].key ? accentBg : Colors.white,
                border: Border.all(
                  color: selected == options[i].key ? accent : border,
                  width: selected == options[i].key ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  options[i].value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected == options[i].key
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: label,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (i < options.length - 1) SizedBox(width: 8),
      ],
    ],
  );
}

Widget _numField(
  TextEditingController c,
  String hint,
  Color hintC,
  Color borderC,
  Color accentC,
  Color labelC,
) {
  return TextField(
    controller: c,
    style: TextStyle(fontSize: 14, color: labelC),
    keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: hintC),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: borderC),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: accentC, width: 2),
      ),
    ),
  );
}

Widget _fileUploadBlock({
  required String title,
  required bool uploaded,
  required String templateUrl,
  required String templateFileName,
  required String countText,
  required Future<bool> Function() onUpload,
  required Color accent,
  required Color titleColor,
  required Color muted,
  required Color success,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE2E8F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: titleColor),
              ),
            ),
            if (templateUrl.isNotEmpty)
              InkWell(
                onTap: () async {
                  await actions.downloadTemplate(templateUrl, templateFileName);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.download, size: 12, color: accent),
                    SizedBox(width: 4),
                    Text('Plantilla',
                        style: TextStyle(
                            fontSize: 11,
                            color: accent,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(
              uploaded ? Icons.check_circle : Icons.upload_file,
              size: 14,
              color: uploaded ? success : muted,
            ),
            SizedBox(width: 6),
            Text(
              uploaded ? countText : 'Ningún archivo cargado',
              style: TextStyle(fontSize: 11, color: uploaded ? success : muted),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                await onUpload();
              },
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: accent),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.upload_file, size: 14, color: accent),
                    SizedBox(width: 4),
                    Text(
                      uploaded ? 'Cambiar CSV' : 'Subir CSV',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
