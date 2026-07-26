// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future resetAppState() async {
  FFAppState().update(() {
    // Project inputs
    FFAppState().installedMw = 0.0;
    FFAppState().devexKeur = 0.0;
    FFAppState().capexTurbineKeur = 0.0;
    FFAppState().capexBopKeur = 0.0;
    FFAppState().capexInterKeur = 0.0;
    FFAppState().ncfP50Pct = 0.0;
    FFAppState().ncfP75Pct = 0.0;
    FFAppState().availabilityPct = 0.0;
    FFAppState().opexYear1Keur = 0.0;
    FFAppState().ipcPct = 0.0;
    FFAppState().waccPct = 0.0;
    FFAppState().ppaPriceEurMwh = 0.0;
    FFAppState().ppaVolumePct = 0.0;
    FFAppState().merchantPriceEurMwh = 0.0;
    FFAppState().debtInterestRatePct = 0.0;
    FFAppState().targetDscrContracted = 0.0;
    FFAppState().targetDscrMerchant = 0.0;
    FFAppState().targetGearingPct = 0.0;
    FFAppState().debtTenorYears = 0;
    FFAppState().projectLifeYears = 0;
    FFAppState().ppaTenorYears = 0;
    FFAppState().projectName = '';
    FFAppState().technology = '';
    FFAppState().degradationPct = 0.0;
    FFAppState().projectDescription = '';

    // Curtailment y perfiles horarios
    FFAppState().curtailmentMode = 'none';
    FFAppState().curtailmentRatePct = 0.0;
    FFAppState().ppaCoversNegativeHours = true;
    FFAppState().spotPriceGrowthPct = 1.5;
    FFAppState().generationProfile = <double>[];
    FFAppState().priceProfile = <double>[];
    FFAppState().generationFileUploaded = false;
    FFAppState().priceFileUploaded = false;
    FFAppState().parseErrorMessage = '';

    // Model outputs
    FFAppState().projectIrrPct = 0.0;
    FFAppState().equityIrrPct = 0.0;
    FFAppState().projectNpvKeur = 0.0;
    FFAppState().lcoeEurMwh = 0.0;
    FFAppState().minDscr = 0.0;
    FFAppState().avgDscr = 0.0;
    FFAppState().debtKeur = 0.0;
    FFAppState().equityKeur = 0.0;
    FFAppState().gearingPct = 0.0;
    FFAppState().bindingConstraint = '';
    FFAppState().irrWaccRatio = 0.0;
    FFAppState().npvCapexRatio = 0.0;
    FFAppState().paybackYears = 0.0;
    FFAppState().contractedNpvKeur = 0.0;

    // Model series
    FFAppState().cfadsKeur = <double>[];
    FFAppState().debtSvc = <double>[];
    FFAppState().dscr = <double>[];
    FFAppState().equityCfKeur = <double>[];
    FFAppState().openDebt = <double>[];
    FFAppState().opexKeur = <double>[];
    FFAppState().p50Mwh = <double>[];
    FFAppState().totalRevKeur = <double>[];
    FFAppState().years = <int>[];
    FFAppState().principal = <double>[];
    FFAppState().interest = <double>[];
    FFAppState().closeDebt = <double>[];

    // Flag de escenario cargado + fecha
    FFAppState().scenarioLoaded = false;
    FFAppState().lastCalculationDate = null;
  });
}
