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
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> runGoalSeek(
  String target,
  double value,
  String move,
) async {
  const String apiUrl = 'https://renewable-model-auybcyvgja-ew.a.run.app';

  final socFormatted = FFAppState().socDate != null
      ? FFAppState().socDate!.toString().split(' ')[0]
      : '';
  final codFormatted = FFAppState().codDate != null
      ? FFAppState().codDate!.toString().split(' ')[0]
      : '';

  final Map<String, dynamic> payload = {
    'technology': FFAppState().technology,
    'curtailment_mode': FFAppState().curtailmentMode,
    'curtailment_rate_pct': FFAppState().curtailmentRatePct,
    'ppa_covers_negative_hours': FFAppState().ppaCoversNegativeHours,
    'spot_price_growth_pct': FFAppState().spotPriceGrowthPct,
    'generation_profile': FFAppState().generationProfile,
    'price_profile': FFAppState().priceProfile,
    'degradation_pct': FFAppState().degradationPct,
    'installed_mw': FFAppState().installedMw,
    'devex_keur': FFAppState().devexKeur,
    'capex_turbine_keur': FFAppState().capexTurbineKeur,
    'capex_bop_keur': FFAppState().capexBopKeur,
    'capex_interconnection_keur': FFAppState().capexInterKeur,
    'ncf_p50_pct': FFAppState().ncfP50Pct,
    'ncf_p75_pct': FFAppState().ncfP75Pct,
    'availability_pct': FFAppState().availabilityPct,
    'opex_year1_keur': FFAppState().opexYear1Keur,
    'ipc_pct': FFAppState().ipcPct,
    'wacc_pct': FFAppState().waccPct,
    'ppa_price_eur_mwh': FFAppState().ppaPriceEurMwh,
    'ppa_tenor_years': FFAppState().ppaTenorYears,
    'ppa_volume_pct': FFAppState().ppaVolumePct,
    'merchant_price_eur_mwh': FFAppState().merchantPriceEurMwh,
    'project_life_years': FFAppState().projectLifeYears,
    'debt_interest_rate_pct': FFAppState().debtInterestRatePct,
    'debt_tenor_years': FFAppState().debtTenorYears,
    'target_dscr_contracted': FFAppState().targetDscrContracted,
    'target_dscr_merchant': FFAppState().targetDscrMerchant,
    'target_gearing_pct': FFAppState().targetGearingPct,
    'soc_date': socFormatted,
    'cod_date': codFormatted,
    'index_capex_turbine': FFAppState().indexCapexTurbine,
    'index_capex_bop': FFAppState().indexCapexBop,
    'index_capex_inter': FFAppState().indexCapexInterconn,
    'goal_seek': {
      'target': target,
      'value': value,
      'move': move,
    },
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (response.statusCode != 200) {
      return jsonEncode({
        'found': false,
        'reason': 'Error del servidor: ${response.statusCode}',
      });
    }
    return response.body;
  } catch (e) {
    return jsonEncode({
      'found': false,
      'reason': 'Error de conexión: $e',
    });
  }
}
