// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';

import '/auth/firebase_auth/auth_util.dart';
import 'dart:convert';

double _num(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString()) ?? 0;
}

int _int(dynamic v) {
  if (v == null) return 0;
  if (v is num) return v.round();
  return double.tryParse(v.toString())?.round() ?? 0;
}

DateTime? _date(dynamic v) {
  if (v == null) return null;
  if (v is String && v.isNotEmpty) {
    try {
      return DateTime.parse(v);
    } catch (_) {
      return null;
    }
  }
  return null;
}

Future<bool> loadScenario(String scenarioId) async {
  try {
    final doc = await ScenariosRecord.collection.doc(scenarioId).get();
    if (!doc.exists) return false;
    final d = doc.data() as Map<String, dynamic>;

    final assumptions =
        jsonDecode(d['assumptions'] ?? '{}') as Map<String, dynamic>;
    final outputs = jsonDecode(d['outputs'] ?? '{}') as Map<String, dynamic>;

    FFAppState().update(() {
      // Cabecera
      FFAppState().projectName = d['projectName'] ?? '';
      FFAppState().projectDescription = d['projectDescription'] ?? '';
      FFAppState().technology = d['technology'] ?? '';

      // Curtailment
      FFAppState().curtailmentMode = assumptions['curtailmentMode'] ?? 'none';
      FFAppState().curtailmentRatePct = _num(assumptions['curtailmentRatePct']);
      FFAppState().ppaCoversNegativeHours =
          assumptions['ppaCoversNegativeHours'] ?? false;
      FFAppState().spotPriceGrowthPct = _num(assumptions['spotPriceGrowthPct']);
      FFAppState().degradationPct = _num(assumptions['degradationPct']);

      // Inputs financieros
      FFAppState().installedMw = _num(assumptions['installedMw']);
      FFAppState().installedDCMw = _num(assumptions['installedDCMw']);
      FFAppState().devexKeur = _num(assumptions['devexKeur']);
      FFAppState().capexTurbineKeur = _num(assumptions['capexTurbineKeur']);
      FFAppState().capexBopKeur = _num(assumptions['capexBopKeur']);
      FFAppState().capexInterKeur = _num(assumptions['capexInterKeur']);
      FFAppState().capexEquiposSolaresCentWp =
          _num(assumptions['capexEquiposSolaresCentWp']);
      FFAppState().capexBoSCentWp = _num(assumptions['capexBoSCentWp']);
      FFAppState().ncfP50Pct = _num(assumptions['ncfP50Pct']);
      FFAppState().ncfP75Pct = _num(assumptions['ncfP75Pct']);
      FFAppState().availabilityPct = _num(assumptions['availabilityPct']);
      FFAppState().opexYear1Keur = _num(assumptions['opexYear1Keur']);
      FFAppState().opexMode = (assumptions['opexMode'] ?? '').toString();
      final bandsRaw = assumptions['opexWtgBands'];
      FFAppState().opexWtgBands = (bandsRaw is List)
          ? List<double>.from(bandsRaw.map((e) => _num(e)))
          : <double>[];
      FFAppState().ipcPct = _num(assumptions['ipcPct']);
      FFAppState().waccPct = _num(assumptions['waccPct']);
      FFAppState().ppaPriceEurMwh = _num(assumptions['ppaPriceEurMwh']);
      FFAppState().ppaTenorYears = _int(assumptions['ppaTenorYears']);
      FFAppState().ppaVolumePct = _num(assumptions['ppaVolumePct']);
      FFAppState().merchantPriceEurMwh =
          _num(assumptions['merchantPriceEurMwh']);
      FFAppState().projectLifeYears = _int(assumptions['projectLifeYears']);
      FFAppState().debtInterestRatePct =
          _num(assumptions['debtInterestRatePct']);
      FFAppState().debtTenorYears = _int(assumptions['debtTenorYears']);
      FFAppState().targetDscrContracted =
          _num(assumptions['targetDscrContracted']);
      FFAppState().targetDscrMerchant = _num(assumptions['targetDscrMerchant']);
      FFAppState().targetGearingPct = _num(assumptions['targetGearingPct']);

      // Cronograma
      FFAppState().socDate = _date(assumptions['socDate']);
      FFAppState().codDate = _date(assumptions['codDate']);
      FFAppState().indexCapexTurbine =
          assumptions['indexCapexTurbine'] ?? false;
      FFAppState().indexCapexBop = assumptions['indexCapexBop'] ?? false;
      FFAppState().indexCapexInterconn =
          assumptions['indexCapexInterconn'] ?? false;

      // Outputs
      FFAppState().projectIrrPct = _num(outputs['projectIrrPct']);
      FFAppState().equityIrrPct = _num(outputs['equityIrrPct']);
      FFAppState().projectNpvKeur = _num(outputs['projectNpvKeur']);
      FFAppState().contractedNpvKeur = _num(outputs['contractedNpvKeur']);
      FFAppState().lcoeEurMwh = _num(outputs['lcoeEurMwh']);
      FFAppState().minDscr = _num(outputs['minDscr']);
      FFAppState().avgDscr = _num(outputs['avgDscr']);
      FFAppState().minDscrBank = _num(outputs['minDscrBank']);
      FFAppState().avgDscrBank = _num(outputs['avgDscrBank']);
      FFAppState().irrWaccRatio = _num(outputs['irrWaccRatio']);
      FFAppState().npvCapexRatio = _num(outputs['npvCapexRatio']);
      FFAppState().paybackYears = _num(outputs['paybackYears']);
      FFAppState().debtKeur = _num(outputs['debtKeur']);
      FFAppState().equityKeur = _num(outputs['equityKeur']);
      FFAppState().gearingPct = _num(outputs['gearingPct']);
      FFAppState().bindingConstraint =
          (outputs['bindingConstraint'] ?? '').toString();
      FFAppState().capexIndexedTotalKeur =
          _num(outputs['capexIndexedTotalKeur']);
      FFAppState().idcKeur = _num(outputs['idcKeur']);
      FFAppState().dsraKeur = _num(outputs['dsraKeur']);

      // Perfiles
      FFAppState().generationProfile =
          List<double>.from((d['generationProfile'] ?? []).map((e) => _num(e)));
      FFAppState().priceProfile =
          List<double>.from((d['priceProfile'] ?? []).map((e) => _num(e)));
      FFAppState().generationFileUploaded =
          FFAppState().generationProfile.isNotEmpty;
      FFAppState().priceFileUploaded = FFAppState().priceProfile.isNotEmpty;

      FFAppState().scenarioLoaded = true;
    });

    return true;
  } catch (e) {
    return false;
  }
}
