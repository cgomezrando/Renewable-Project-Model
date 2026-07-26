// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/app_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> calculateHourly(BuildContext context) async {
  const String apiUrl = 'https://renewable-model-auybcyvgja-ew.a.run.app';

  final mw = FFAppState().installedMw;
  final life = FFAppState().projectLifeYears;
  if (mw <= 0) {
    _showError(context, 'MW Instalados debe ser mayor que 0');
    return false;
  }
  if (life <= 0) {
    _showError(context, 'Vida del Proyecto debe ser mayor que 0 años');
    return false;
  }

  final socFormatted = FFAppState().socDate != null
      ? FFAppState().socDate!.toString().split(' ')[0]
      : '';
  final codFormatted = FFAppState().codDate != null
      ? FFAppState().codDate!.toString().split(' ')[0]
      : '';

  try {
    final Map<String, dynamic> payload = {
      'technology': FFAppState().technology,
      'curtailment_mode': FFAppState().curtailmentMode,
      'curtailment_rate_pct': FFAppState().curtailmentRatePct,
      'ppa_covers_negative_hours': FFAppState().ppaCoversNegativeHours,
      'spot_price_growth_pct': FFAppState().spotPriceGrowthPct,
      'generation_profile': FFAppState().generationProfile,
      'price_profile': FFAppState().priceProfile,
      'degradation_pct': FFAppState().degradationPct,
      'installed_mw': mw,
      'devex_keur': FFAppState().devexKeur,
      'capex_turbine_keur': FFAppState().capexTurbineKeur,
      'capex_bop_keur': FFAppState().capexBopKeur,
      'capex_interconnection_keur': FFAppState().capexInterKeur,
      'ncf_p50_pct': FFAppState().ncfP50Pct,
      'ncf_p75_pct': FFAppState().ncfP75Pct,
      'availability_pct': FFAppState().availabilityPct,
      'opex_year1_keur': FFAppState().opexYear1Keur,
      'opex_wtg_bands': FFAppState().opexMode == 'bands'
          ? FFAppState().opexWtgBands
          : <double>[],
      'ipc_pct': FFAppState().ipcPct,
      'wacc_pct': FFAppState().waccPct,
      'ppa_price_eur_mwh': FFAppState().ppaPriceEurMwh,
      'ppa_tenor_years': FFAppState().ppaTenorYears,
      'ppa_volume_pct': FFAppState().ppaVolumePct,
      'merchant_price_eur_mwh': FFAppState().merchantPriceEurMwh,
      'project_life_years': life,
      'debt_interest_rate_pct': FFAppState().debtInterestRatePct,
      'debt_tenor_years': FFAppState().debtTenorYears,
      'target_dscr_contracted': FFAppState().targetDscrContracted,
      'target_dscr_merchant': FFAppState().targetDscrMerchant,
      'max_gearing_pct': FFAppState().targetGearingPct,
      'soc_date': socFormatted,
      'cod_date': codFormatted,
      'index_capex_turbine': FFAppState().indexCapexTurbine,
      'index_capex_bop': FFAppState().indexCapexBop,
      'index_capex_inter': FFAppState().indexCapexInterconn,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode != 200) {
      _showError(context, 'Error en cálculo: ${response.statusCode}');
      return false;
    }

    final dynamic result = jsonDecode(response.body);
    final outputs = result['outputs'] ?? {};
    final financing = result['financing'] ?? {};
    final annual = result['annual'] ?? {};

    FFAppState().update(() {
      FFAppState().projectIrrPct =
          (outputs['project_irr_pct'] ?? 0.0).toDouble();
      FFAppState().equityIrrPct = (outputs['equity_irr_pct'] ?? 0.0).toDouble();
      FFAppState().projectNpvKeur =
          (outputs['project_npv_keur'] ?? 0.0).toDouble();
      FFAppState().contractedNpvKeur =
          (outputs['contracted_npv_keur'] ?? 0.0).toDouble();
      FFAppState().lcoeEurMwh = (outputs['lcoe_eur_mwh'] ?? 0.0).toDouble();
      FFAppState().minDscr = (outputs['min_dscr'] ?? 0.0).toDouble();
      FFAppState().avgDscr = (outputs['avg_dscr'] ?? 0.0).toDouble();
      FFAppState().minDscrBank = (outputs['min_dscr_bank'] ?? 0.0).toDouble();
      FFAppState().avgDscrBank = (outputs['avg_dscr_bank'] ?? 0.0).toDouble();
      FFAppState().irrWaccRatio = (outputs['irr_wacc_ratio'] ?? 0.0).toDouble();
      FFAppState().npvCapexRatio =
          (outputs['npv_capex_ratio'] ?? 0.0).toDouble();
      FFAppState().paybackYears = (outputs['payback_years'] ?? 0.0).toDouble();

      FFAppState().debtKeur = (financing['debt_keur'] ?? 0.0).toDouble();
      FFAppState().equityKeur = (financing['equity_keur'] ?? 0.0).toDouble();
      FFAppState().gearingPct = (financing['gearing_pct'] ?? 0.0).toDouble();
      FFAppState().bindingConstraint =
          (financing['binding_constraint'] ?? '').toString();
      FFAppState().capexIndexedTotalKeur =
          (financing['capex_indexed_total_keur'] ?? 0.0).toDouble();
      FFAppState().idcKeur = (financing['idc_keur'] ?? 0.0).toDouble();
      FFAppState().dsraKeur = (financing['dsra_keur'] ?? 0.0).toDouble();

      FFAppState().years = List<int>.from(annual['years'] ?? []);
      FFAppState().cfadsKeur = List<double>.from(
          (annual['cfads_keur'] ?? []).map((e) => e.toDouble()));
      FFAppState().debtSvc = List<double>.from(
          (annual['debt_svc'] ?? []).map((e) => e.toDouble()));
      FFAppState().dscr =
          List<double>.from((annual['dscr'] ?? []).map((e) => e.toDouble()));
      FFAppState().equityCfKeur = List<double>.from(
          (annual['equity_cf_keur'] ?? []).map((e) => e.toDouble()));
      FFAppState().openDebt = List<double>.from(
          (annual['open_debt'] ?? []).map((e) => e.toDouble()));
      FFAppState().opexKeur = List<double>.from(
          (annual['opex_keur'] ?? []).map((e) => e.toDouble()));
      FFAppState().p50Mwh =
          List<double>.from((annual['p50_mwh'] ?? []).map((e) => e.toDouble()));
      FFAppState().totalRevKeur = List<double>.from(
          (annual['total_rev_keur'] ?? []).map((e) => e.toDouble()));
      FFAppState().principal = List<double>.from(
          (annual['principal'] ?? []).map((e) => e.toDouble()));
      FFAppState().interest = List<double>.from(
          (annual['interest'] ?? []).map((e) => e.toDouble()));
      FFAppState().closeDebt = List<double>.from(
          (annual['close_debt'] ?? []).map((e) => e.toDouble()));
    });

    return true;
  } catch (e) {
    _showError(context, 'Error al calcular: $e');
    return false;
  }
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: const Color(0xFFDC2626),
      duration: const Duration(seconds: 4),
    ),
  );
}
