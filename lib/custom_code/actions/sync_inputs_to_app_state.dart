// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

double _d(String? s) {
  if (s == null || s.trim().isEmpty) return 0;
  return double.tryParse(s.trim().replaceAll(',', '.')) ?? 0;
}

int _i(String? s) {
  if (s == null || s.trim().isEmpty) return 0;
  return double.tryParse(s.trim().replaceAll(',', '.'))?.round() ?? 0;
}

Future syncInputsToAppState(
  String installedMw,
  String devexKeur,
  String capexTurbineKeur,
  String capexBopKeur,
  String capexInterKeur,
  String ncfP50Pct,
  String ncfP75Pct,
  String availabilityPct,
  String opexYear1Keur,
  String ipcPct,
  String waccPct,
  String ppaPriceEurMwh,
  String ppaTenorYears,
  String ppaVolumePct,
  String merchantPriceEurMwh,
  String projectLifeYears,
  String debtInterestRatePct,
  String debtTenorYears,
  String targetDscrContracted,
  String targetDscrMerchant,
  String targetGearingPct,
  String capexEquiposSolaresCentWp,
  String capexBoSCentWp,
) async {
  FFAppState().update(() {
    FFAppState().installedMw = _d(installedMw);
    FFAppState().devexKeur = _d(devexKeur);
    FFAppState().capexInterKeur = _d(capexInterKeur);
    FFAppState().ncfP50Pct = _d(ncfP50Pct);
    FFAppState().ncfP75Pct = _d(ncfP75Pct);
    FFAppState().availabilityPct = _d(availabilityPct);
    FFAppState().opexYear1Keur = _d(opexYear1Keur);
    FFAppState().ipcPct = _d(ipcPct);
    FFAppState().waccPct = _d(waccPct);
    FFAppState().ppaPriceEurMwh = _d(ppaPriceEurMwh);
    FFAppState().ppaTenorYears = _i(ppaTenorYears);
    FFAppState().ppaVolumePct = _d(ppaVolumePct);
    FFAppState().merchantPriceEurMwh = _d(merchantPriceEurMwh);
    FFAppState().projectLifeYears = _i(projectLifeYears);
    FFAppState().debtInterestRatePct = _d(debtInterestRatePct);
    FFAppState().debtTenorYears = _i(debtTenorYears);
    FFAppState().targetDscrContracted = _d(targetDscrContracted);
    FFAppState().targetDscrMerchant = _d(targetDscrMerchant);
    FFAppState().targetGearingPct = _d(targetGearingPct);

    final bool isSolar = FFAppState().technology.toLowerCase() == 'solar';

    if (isSolar) {
      // En solar, el CAPEX de equipos y BOS se introduce en c€/Wp.
      // Conversión a k€ totales: c€/Wp × MWp × 10
      final double centEquipos = _d(capexEquiposSolaresCentWp);
      final double centBos = _d(capexBoSCentWp);
      final double dcMw = FFAppState().installedDCMw;

      FFAppState().capexEquiposSolaresCentWp = centEquipos;
      FFAppState().capexBoSCentWp = centBos;

      FFAppState().capexTurbineKeur = centEquipos * dcMw * 10;
      FFAppState().capexBopKeur = centBos * dcMw * 10;
    } else {
      // Wind y BESS: CAPEX en k€ totales directamente.
      FFAppState().capexTurbineKeur = _d(capexTurbineKeur);
      FFAppState().capexBopKeur = _d(capexBopKeur);
    }

    FFAppState().lastCalculationDate = DateTime.now();
  });
}
