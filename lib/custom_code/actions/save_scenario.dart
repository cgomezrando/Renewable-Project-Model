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

Future<String?> saveScenario(String scenarioName) async {
  try {
    final uid = currentUserUid;
    if (uid.isEmpty) return null;

    final assumptionsJson = jsonEncode({
      'curtailmentMode': FFAppState().curtailmentMode,
      'curtailmentRatePct': FFAppState().curtailmentRatePct,
      'ppaCoversNegativeHours': FFAppState().ppaCoversNegativeHours,
      'spotPriceGrowthPct': FFAppState().spotPriceGrowthPct,
      'degradationPct': FFAppState().degradationPct,
      'installedMw': FFAppState().installedMw,
      'installedDCMw': FFAppState().installedDCMw,
      'devexKeur': FFAppState().devexKeur,
      'capexTurbineKeur': FFAppState().capexTurbineKeur,
      'capexBopKeur': FFAppState().capexBopKeur,
      'capexInterKeur': FFAppState().capexInterKeur,
      'capexEquiposSolaresCentWp': FFAppState().capexEquiposSolaresCentWp,
      'capexBoSCentWp': FFAppState().capexBoSCentWp,
      'ncfP50Pct': FFAppState().ncfP50Pct,
      'ncfP75Pct': FFAppState().ncfP75Pct,
      'availabilityPct': FFAppState().availabilityPct,
      'opexYear1Keur': FFAppState().opexYear1Keur,
      'opexMode': FFAppState().opexMode,
      'opexWtgBands': FFAppState().opexWtgBands,
      'ipcPct': FFAppState().ipcPct,
      'waccPct': FFAppState().waccPct,
      'ppaPriceEurMwh': FFAppState().ppaPriceEurMwh,
      'ppaTenorYears': FFAppState().ppaTenorYears,
      'ppaVolumePct': FFAppState().ppaVolumePct,
      'merchantPriceEurMwh': FFAppState().merchantPriceEurMwh,
      'projectLifeYears': FFAppState().projectLifeYears,
      'debtInterestRatePct': FFAppState().debtInterestRatePct,
      'debtTenorYears': FFAppState().debtTenorYears,
      'targetDscrContracted': FFAppState().targetDscrContracted,
      'targetDscrMerchant': FFAppState().targetDscrMerchant,
      'targetGearingPct': FFAppState().targetGearingPct,
      'socDate': FFAppState().socDate?.toIso8601String(),
      'codDate': FFAppState().codDate?.toIso8601String(),
      'indexCapexTurbine': FFAppState().indexCapexTurbine,
      'indexCapexBop': FFAppState().indexCapexBop,
      'indexCapexInterconn': FFAppState().indexCapexInterconn,
    });

    final outputsJson = jsonEncode({
      'projectIrrPct': FFAppState().projectIrrPct,
      'equityIrrPct': FFAppState().equityIrrPct,
      'projectNpvKeur': FFAppState().projectNpvKeur,
      'contractedNpvKeur': FFAppState().contractedNpvKeur,
      'lcoeEurMwh': FFAppState().lcoeEurMwh,
      'minDscr': FFAppState().minDscr,
      'avgDscr': FFAppState().avgDscr,
      'minDscrBank': FFAppState().minDscrBank,
      'avgDscrBank': FFAppState().avgDscrBank,
      'irrWaccRatio': FFAppState().irrWaccRatio,
      'npvCapexRatio': FFAppState().npvCapexRatio,
      'paybackYears': FFAppState().paybackYears,
      'debtKeur': FFAppState().debtKeur,
      'equityKeur': FFAppState().equityKeur,
      'gearingPct': FFAppState().gearingPct,
      'bindingConstraint': FFAppState().bindingConstraint,
      'capexIndexedTotalKeur': FFAppState().capexIndexedTotalKeur,
      'idcKeur': FFAppState().idcKeur,
      'dsraKeur': FFAppState().dsraKeur,
    });

    final docRef = await ScenariosRecord.collection.add({
      'scenarioName': scenarioName,
      'projectName': FFAppState().projectName,
      'projectDescription': FFAppState().projectDescription,
      'technology': FFAppState().technology,
      'createdDate': getCurrentTimestamp,
      'userId': uid,
      'assumptions': assumptionsJson,
      'outputs': outputsJson,
      'generationProfile': FFAppState().generationProfile,
      'priceProfile': FFAppState().priceProfile,
    });

    return docRef.id;
  } catch (e) {
    return null;
  }
}
