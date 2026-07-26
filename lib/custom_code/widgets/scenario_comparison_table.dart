// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart';

import '/auth/firebase_auth/auth_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class ScenarioComparisonTable extends StatefulWidget {
  const ScenarioComparisonTable({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ScenarioComparisonTable> createState() =>
      _ScenarioComparisonTableState();
}

enum _CellType {
  text,
  number,
  percent,
  currencyKeur,
  currencyEurMwh,
  years,
  ratio,
  date,
  technology
}

class _RowSpec {
  final String key;
  final String label;
  final String category;
  final _CellType type;
  final String? unit;
  final int decimals;
  const _RowSpec(this.key, this.label, this.category, this.type,
      {this.unit, this.decimals = 2});
}

class _ScenarioColorPalette {
  final Color accent;
  final Color bg;
  final Color textOnBg;
  const _ScenarioColorPalette(this.accent, this.bg, this.textOnBg);
}

class _ScenarioComparisonTableState extends State<ScenarioComparisonTable> {
  // ============ Paleta ============
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _borderLight = Color(0xFFF1F5F9);
  static const Color _headerBg = Color(0xFFF8FAFC);
  static const Color _sectionBg = Color(0xFFF8FAFC);
  static const Color _labelColor = Color(0xFF0F172A);
  static const Color _mutedColor = Color(0xFF64748B);
  static const Color _emptyColor = Color(0xFFCBD5E1);
  static const Color _accent = Color(0xFF2563EB);

  // Un color por posición de escenario (índice 0..3)
  static const List<_ScenarioColorPalette> _scenarioColors = [
    _ScenarioColorPalette(
        Color(0xFF2563EB), Color(0xFFEFF6FF), Color(0xFF1E40AF)),
    _ScenarioColorPalette(
        Color(0xFF16A34A), Color(0xFFF0FDF4), Color(0xFF166534)),
    _ScenarioColorPalette(
        Color(0xFFF59E0B), Color(0xFFFFFBEB), Color(0xFFB45309)),
    _ScenarioColorPalette(
        Color(0xFF8B5CF6), Color(0xFFF5F3FF), Color(0xFF6D28D9)),
    _ScenarioColorPalette(
        Color(0xFFEC4899), Color(0xFFFDF2F8), Color(0xFFBE185D)),
    _ScenarioColorPalette(
        Color(0xFF0891B2), Color(0xFFECFEFF), Color(0xFF155E75)),
  ];

  static const int _maxScenarios = 6;
  static const int _maxRows = 20;

  static const double _labelColWidth = 240;
  static const double _dataColWidth = 220;

  // ============ Catálogo ============
  static const List<_RowSpec> _catalog = [
    _RowSpec('projectDescription', 'Descripción', 'info', _CellType.text),
    _RowSpec('technology', 'Tecnología', 'info', _CellType.technology),
    _RowSpec('createdDate', 'Fecha creación', 'info', _CellType.date),
    _RowSpec('installedMw', 'MW instalados', 'info', _CellType.number,
        unit: 'MW', decimals: 1),
    _RowSpec('projectLifeYears', 'Vida del proyecto', 'info', _CellType.years,
        decimals: 0),
    _RowSpec('devexKeur', 'DEVEX', 'capex', _CellType.currencyKeur),
    _RowSpec(
        'capexTurbineKeur', 'CAPEX equipos', 'capex', _CellType.currencyKeur),
    _RowSpec('capexBopKeur', 'CAPEX BOP', 'capex', _CellType.currencyKeur),
    _RowSpec('capexInterKeur', 'CAPEX interconexión', 'capex',
        _CellType.currencyKeur),
    _RowSpec('capexTotal', 'CAPEX total', 'capex', _CellType.currencyKeur),
    _RowSpec('capexIndexedTotalKeur', 'CAPEX indexado (total)', 'capex',
        _CellType.currencyKeur),
    _RowSpec('idcKeur', 'IDC', 'capex', _CellType.currencyKeur),
    _RowSpec('dsraKeur', 'DSRA', 'capex', _CellType.currencyKeur),
    _RowSpec('opexYear1Keur', 'OPEX año 1', 'opex', _CellType.currencyKeur),
    _RowSpec('ipcPct', 'IPC', 'opex', _CellType.percent),
    _RowSpec('degradationPct', 'Degradación anual', 'opex', _CellType.percent),
    _RowSpec('availabilityPct', 'Disponibilidad', 'opex', _CellType.percent),
    _RowSpec('ncfP50Pct', 'NCF P50', 'revenue', _CellType.percent),
    _RowSpec('ncfP75Pct', 'NCF P75', 'revenue', _CellType.percent),
    _RowSpec('merchantPriceEurMwh', 'Precio Merchant', 'revenue',
        _CellType.currencyEurMwh),
    _RowSpec(
        'ppaPriceEurMwh', 'Precio PPA', 'revenue', _CellType.currencyEurMwh),
    _RowSpec('ppaVolumePct', 'Volumen PPA', 'revenue', _CellType.percent),
    _RowSpec('ppaTenorYears', 'Tenor PPA', 'revenue', _CellType.years,
        decimals: 0),
    _RowSpec('curtailmentMode', 'Curtailment', 'revenue', _CellType.text),
    _RowSpec(
        'spotPriceGrowthPct', 'Crecimiento spot', 'revenue', _CellType.percent),
    _RowSpec('debtInterestRatePct', 'Interés deuda', 'debt', _CellType.percent),
    _RowSpec('debtTenorYears', 'Tenor deuda', 'debt', _CellType.years,
        decimals: 0),
    _RowSpec('targetGearingPct', 'Target Gearing', 'debt', _CellType.percent),
    _RowSpec(
        'targetDscrMerchant', 'DSCR merchant obj.', 'debt', _CellType.ratio),
    _RowSpec('targetDscrContracted', 'DSCR contratado obj.', 'debt',
        _CellType.ratio),
    _RowSpec('waccPct', 'WACC', 'debt', _CellType.percent),
    _RowSpec('projectIrrPct', 'Project IRR', 'output', _CellType.percent),
    _RowSpec('equityIrrPct', 'Equity IRR', 'output', _CellType.percent),
    _RowSpec('projectNpvKeur', 'Project NPV', 'output', _CellType.currencyKeur),
    _RowSpec('contractedNpvKeur', 'NPV contratado', 'output',
        _CellType.currencyKeur),
    _RowSpec('lcoeEurMwh', 'LCOE', 'output', _CellType.currencyEurMwh),
    _RowSpec('minDscr', 'DSCR mín.', 'output', _CellType.ratio),
    _RowSpec('avgDscr', 'DSCR medio', 'output', _CellType.ratio),
    _RowSpec('minDscrBank', 'DSCR banco mín.', 'output', _CellType.ratio),
    _RowSpec('avgDscrBank', 'DSCR banco medio', 'output', _CellType.ratio),
    _RowSpec('paybackYears', 'Payback', 'output', _CellType.years, decimals: 1),
    _RowSpec('gearingPct', 'Gearing final', 'output', _CellType.percent),
    _RowSpec('debtKeur', 'Deuda', 'output', _CellType.currencyKeur),
    _RowSpec('equityKeur', 'Equity', 'output', _CellType.currencyKeur),
    _RowSpec('irrWaccRatio', 'IRR / WACC', 'output', _CellType.ratio),
    _RowSpec('npvCapexRatio', 'NPV / CAPEX', 'output', _CellType.ratio),
    _RowSpec(
        'bindingConstraint', 'Restricción activa', 'output', _CellType.text),
  ];

  static const Map<String, String> _categoryLabels = {
    'info': 'Información general',
    'capex': 'Inversión (CAPEX)',
    'opex': 'Operación (OPEX)',
    'revenue': 'Ingresos',
    'debt': 'Deuda y financiación',
    'output': 'Resultados',
  };

  static const Map<String, IconData> _categoryIcons = {
    'info': Icons.info_outline,
    'capex': Icons.account_balance_wallet_outlined,
    'opex': Icons.build_outlined,
    'revenue': Icons.trending_up,
    'debt': Icons.credit_card_outlined,
    'output': Icons.bar_chart_outlined,
  };

  static const List<String> _defaultRows = [
    'projectDescription',
    'installedMw',
    'capexTotal',
    'projectIrrPct',
    'equityIrrPct',
    'lcoeEurMwh',
    'minDscr',
    'paybackYears',
  ];

  List<String> _selectedIds = [];
  final Map<String, Map<String, dynamic>> _cache = {};

  List<String> get _visibleRows {
    final v = FFAppState().visibleComparisonRows;
    if (v.isEmpty) return _defaultRows;
    return v;
  }

  // Agrupa las filas visibles por categoría, preservando el orden del catálogo
  List<MapEntry<String, List<_RowSpec>>> _groupedVisibleRows() {
    final visible = _visibleRows.toSet();
    final byCategory = <String, List<_RowSpec>>{};
    for (final spec in _catalog) {
      if (!visible.contains(spec.key)) continue;
      byCategory.putIfAbsent(spec.category, () => []).add(spec);
    }
    return byCategory.entries.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          Expanded(child: _buildTableCard()),
        ],
      ),
    );
  }

  // ============ HEADER SUPERIOR ============
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comparativa de escenarios',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: _labelColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Compara indicadores financieros y operativos entre los escenarios guardados de tu proyecto.',
                style: TextStyle(
                  fontSize: 13,
                  color: _mutedColor,
                ),
              ),
            ],
          ),
        ),
        _toolbarButton(
          icon: Icons.tune,
          label: 'Filas',
          onTap: _openRowSelector,
        ),
        const SizedBox(width: 8),
        _toolbarButton(
          icon: Icons.refresh,
          label: 'Reiniciar',
          onTap: () {
            setState(() {
              _selectedIds.clear();
              _cache.clear();
              FFAppState().update(() {
                FFAppState().visibleComparisonRows = [];
              });
            });
          },
        ),
      ],
    );
  }

  Widget _toolbarButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    const Color blueAccent = Color(0xFF2563EB);
    const Color blueBg = Color(0xFFDBEAFE);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: blueBg,
          border: Border.all(color: blueAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: blueAccent),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ TABLA ============
  Widget _buildTableCard() {
    final columns = List<String?>.from(_selectedIds);
    while (columns.length < _maxScenarios) {
      columns.add(null);
    }
    final grouped = _groupedVisibleRows();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _border),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A0F172A),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderRow(columns),
              for (int g = 0; g < grouped.length; g++) ...[
                _buildCategoryRow(grouped[g].key, columns),
                for (int i = 0; i < grouped[g].value.length; i++)
                  _buildDataRow(
                    grouped[g].value[i],
                    columns,
                    isLast: g == grouped.length - 1 &&
                        i == grouped[g].value.length - 1,
                  ),
              ],
              if (grouped.isEmpty) _buildEmptyRows(columns),
            ],
          ),
        ),
      ),
    );
  }

  // ============ FILA DE HEADERS DE ESCENARIO ============
  Widget _buildHeaderRow(List<String?> columns) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cell(
            width: _labelColWidth,
            bg: _headerBg,
            border: const Border(bottom: BorderSide(color: _border)),
            child: const Text(
              'Indicador',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _labelColor,
                letterSpacing: 0.4,
              ),
            ),
          ),
          for (int i = 0; i < columns.length; i++)
            _buildScenarioHeaderCell(columns[i], i),
        ],
      ),
    );
  }

  Widget _buildScenarioHeaderCell(String? scenarioId, int index) {
    if (scenarioId == null) {
      final bool clickable = _selectedIds.length < _maxScenarios;
      return _cell(
        width: _dataColWidth,
        bg: Colors.white,
        leftBorder: true,
        border: const Border(bottom: BorderSide(color: _border)),
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: clickable ? _openScenarioPicker : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline,
                    size: 18, color: clickable ? _accent : _emptyColor),
                const SizedBox(width: 8),
                Text(
                  'Agregar escenario',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: clickable ? _accent : _emptyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final palette = _scenarioColors[index % _scenarioColors.length];
    final data = _cache[scenarioId];
    final tech = ((data?['technology'] ?? '') as String).toLowerCase();
    final projectName = (data?['projectName'] ?? '') as String;
    final scenarioName = (data?['scenarioName'] ?? '') as String;

    return _cell(
      width: _dataColWidth,
      bg: palette.bg,
      leftBorder: true,
      border: Border(
        bottom: BorderSide(color: palette.accent, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: palette.accent, width: 1.5),
                ),
                child: Center(
                  child: Icon(_techIcon(tech), size: 14, color: palette.accent),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName.isEmpty ? '(Sin nombre)' : projectName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: palette.textOnBg,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (scenarioName.isNotEmpty)
                      Text(
                        scenarioName,
                        style: TextStyle(
                          fontSize: 10,
                          color: palette.textOnBg.withOpacity(0.75),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedIds.removeAt(index);
                  });
                },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.close,
                      size: 14, color: palette.textOnBg.withOpacity(0.7)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============ FILA DE CATEGORÍA ============
  Widget _buildCategoryRow(String category, List<String?> columns) {
    final label = _categoryLabels[category] ?? category;
    final icon = _categoryIcons[category] ?? Icons.circle;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cell(
            width: _labelColWidth,
            bg: _sectionBg,
            border: const Border(bottom: BorderSide(color: _border)),
            child: Row(
              children: [
                Icon(icon, size: 18, color: _accent),
                const SizedBox(width: 10),
                Text(
                  label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _labelColor,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < columns.length; i++)
            _cell(
              width: _dataColWidth,
              bg: _sectionBg,
              leftBorder: true,
              border: const Border(bottom: BorderSide(color: _border)),
              child: const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }

  // ============ FILA DE DATO ============
  Widget _buildDataRow(_RowSpec spec, List<String?> columns,
      {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cell(
            width: _labelColWidth,
            bg: Colors.white,
            border: isLast
                ? null
                : const Border(bottom: BorderSide(color: _borderLight)),
            child: Text(
              spec.label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _labelColor,
              ),
            ),
          ),
          for (int i = 0; i < columns.length; i++)
            _cell(
              width: _dataColWidth,
              bg: Colors.white,
              leftBorder: true,
              border: isLast
                  ? null
                  : const Border(bottom: BorderSide(color: _borderLight)),
              child: _valueCell(spec, columns[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyRows(List<String?> columns) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: const Center(
        child: Text(
          'Selecciona filas para comparar desde el botón "Filas".',
          style: TextStyle(fontSize: 12, color: _mutedColor),
        ),
      ),
    );
  }

  Widget _valueCell(_RowSpec spec, String? scenarioId) {
    if (scenarioId == null) {
      return const Text('—',
          style: TextStyle(
            fontSize: 13,
            color: _emptyColor,
            fontWeight: FontWeight.w500,
          ));
    }
    final data = _cache[scenarioId];
    if (data == null) {
      return const SizedBox(
        width: 12,
        height: 12,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      );
    }
    final v = _resolveValue(spec.key, data);
    return Text(
      _formatValue(spec, v),
      style: const TextStyle(
        fontSize: 13,
        color: _labelColor,
        fontWeight: FontWeight.w500,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
    );
  }

  // ============ RESOLUCIÓN Y FORMATO ============
  dynamic _resolveValue(String key, Map<String, dynamic> data) {
    if (const {
      'projectName',
      'projectDescription',
      'technology',
      'scenarioName',
      'createdDate',
    }.contains(key)) {
      return data[key];
    }
    if (key == 'capexTotal') {
      final a = data['_assumptions'] as Map? ?? {};
      final t = a['capexTurbineKeur'] ?? 0;
      final b = a['capexBopKeur'] ?? 0;
      final c = a['capexInterKeur'] ?? 0;
      return _toNum(t) + _toNum(b) + _toNum(c);
    }
    final a = data['_assumptions'] as Map? ?? {};
    if (a.containsKey(key)) return a[key];
    final o = data['_outputs'] as Map? ?? {};
    if (o.containsKey(key)) return o[key];
    return null;
  }

  double _toNum(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  String _formatValue(_RowSpec spec, dynamic v) {
    if (v == null) return '—';
    switch (spec.type) {
      case _CellType.text:
        final s = v.toString();
        return s.isEmpty ? '—' : s;
      case _CellType.technology:
        final t = (v as String).toLowerCase();
        if (t == 'wind') return 'Eólico';
        if (t == 'solar') return 'Solar FV';
        if (t == 'bess') return 'BESS';
        return t.isEmpty ? '—' : t;
      case _CellType.number:
        return '${_fmt(_toNum(v), spec.decimals)}${spec.unit != null ? ' ${spec.unit}' : ''}';
      case _CellType.percent:
        return '${_fmt(_toNum(v), spec.decimals)} %';
      case _CellType.currencyKeur:
        return '${_fmtThousand(_toNum(v))} k€';
      case _CellType.currencyEurMwh:
        return '${_fmt(_toNum(v), spec.decimals)} €/MWh';
      case _CellType.years:
        return '${_fmt(_toNum(v), spec.decimals)} años';
      case _CellType.ratio:
        return _fmt(_toNum(v), spec.decimals);
      case _CellType.date:
        if (v is Timestamp) return _fmtDate(v.toDate());
        if (v is DateTime) return _fmtDate(v);
        return '—';
    }
  }

  String _fmt(double v, int dec) {
    return v.toStringAsFixed(dec).replaceAll('.', ',');
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

  String _fmtDate(DateTime d) {
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
    return '${d.day} ${meses[d.month - 1]} ${d.year}';
  }

  IconData _techIcon(String t) {
    switch (t) {
      case 'wind':
        return Icons.air;
      case 'solar':
        return Icons.wb_sunny;
      case 'bess':
        return Icons.battery_charging_full;
      default:
        return Icons.insert_drive_file;
    }
  }

  Widget _cell({
    required double width,
    required Widget child,
    Color bg = Colors.white,
    Border? border,
    bool leftBorder = false,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  }) {
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        border: Border(
          left: leftBorder ? BorderSide(color: _border) : BorderSide.none,
          bottom: border?.bottom ?? BorderSide.none,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  // ============ INTERACCIONES ============
  Future<void> _openScenarioPicker() async {
    if (_selectedIds.length >= _maxScenarios) return;

    final docs = await ScenariosRecord.collection
        .where('userId', isEqualTo: currentUserUid)
        .get();
    final all = docs.docs.where((d) => !_selectedIds.contains(d.id)).toList()
      ..sort((a, b) {
        final da = (a.data() as Map<String, dynamic>)['createdDate'];
        final db = (b.data() as Map<String, dynamic>)['createdDate'];
        if (da is! Timestamp || db is! Timestamp) return 0;
        return db.compareTo(da);
      });

    if (!mounted) return;

    final chosen = await showDialog<String>(
      context: context,
      builder: (ctx) => _ScenarioPickerDialog(docs: all),
    );

    if (chosen != null) {
      final doc = await ScenariosRecord.collection.doc(chosen).get();
      final raw = doc.data() as Map<String, dynamic>;
      setState(() {
        _selectedIds.add(chosen);
        _cache[chosen] = {
          ...raw,
          '_assumptions': _tryDecode(raw['assumptions']),
          '_outputs': _tryDecode(raw['outputs']),
        };
      });
    }
  }

  Map<String, dynamic> _tryDecode(dynamic v) {
    if (v is String && v.isNotEmpty) {
      try {
        return jsonDecode(v) as Map<String, dynamic>;
      } catch (_) {}
    }
    return {};
  }

  Future<void> _openRowSelector() async {
    final current = List<String>.from(_visibleRows);
    final result = await showDialog<List<String>>(
      context: context,
      builder: (ctx) => _RowSelectorDialog(
        catalog: _catalog,
        categoryLabels: _categoryLabels,
        categoryIcons: _categoryIcons,
        currentSelection: current,
        maxRows: _maxRows,
      ),
    );
    if (result != null) {
      FFAppState().update(() {
        FFAppState().visibleComparisonRows = result;
      });
      setState(() {});
    }
  }
}

// ==================== DIÁLOGO SELECCIÓN DE ESCENARIO ====================
class _ScenarioPickerDialog extends StatelessWidget {
  final List<QueryDocumentSnapshot> docs;
  const _ScenarioPickerDialog({required this.docs});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 480,
        constraints: const BoxConstraints(maxHeight: 560),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Añadir escenario',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Elige un escenario para añadir a la comparativa.',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: docs.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Text(
                          'No hay más escenarios para añadir.',
                          style: TextStyle(color: Color(0xFF64748B)),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: docs.map((doc) {
                          final d = doc.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(doc.id),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFE2E8F0)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (d['projectName'] ?? '') as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                    Text(
                                      (d['projectDescription'] ?? '') as String,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Navigator.of(context).pop(null),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== DIÁLOGO SELECCIÓN DE FILAS ====================
class _RowSelectorDialog extends StatefulWidget {
  final List<_RowSpec> catalog;
  final Map<String, String> categoryLabels;
  final Map<String, IconData> categoryIcons;
  final List<String> currentSelection;
  final int maxRows;
  const _RowSelectorDialog({
    required this.catalog,
    required this.categoryLabels,
    required this.categoryIcons,
    required this.currentSelection,
    required this.maxRows,
  });

  @override
  State<_RowSelectorDialog> createState() => _RowSelectorDialogState();
}

class _RowSelectorDialogState extends State<_RowSelectorDialog> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<String>.from(widget.currentSelection);
  }

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<_RowSpec>>{};
    for (final r in widget.catalog) {
      grouped.putIfAbsent(r.category, () => []).add(r);
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 560,
        constraints: const BoxConstraints(maxHeight: 680),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Elegir filas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${_selected.length} / ${widget.maxRows}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF475569),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Selecciona hasta 20 indicadores para mostrar en la tabla.',
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final entry in grouped.entries) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 6),
                        child: Row(
                          children: [
                            Icon(
                              widget.categoryIcons[entry.key] ?? Icons.circle,
                              size: 14,
                              color: const Color(0xFF64748B),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              (widget.categoryLabels[entry.key] ?? entry.key)
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF64748B),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (final r in entry.value) _buildRowItem(r),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(null),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(_selected),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Aplicar',
                          style: TextStyle(
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
    );
  }

  Widget _buildRowItem(_RowSpec r) {
    final selected = _selected.contains(r.key);
    final full = _selected.length >= widget.maxRows;
    final disabled = !selected && full;

    return InkWell(
      onTap: disabled
          ? null
          : () {
              setState(() {
                if (selected) {
                  _selected.remove(r.key);
                } else {
                  _selected.add(r.key);
                }
              });
            },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF2563EB)
                      : const Color(0xFFCBD5E1),
                  width: 2,
                ),
                color: selected ? const Color(0xFF2563EB) : Colors.white,
              ),
              child: selected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                r.label,
                style: TextStyle(
                  fontSize: 13,
                  color: disabled
                      ? const Color(0xFFCBD5E1)
                      : const Color(0xFF0F172A),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
