import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  double _installedMw = 0.0;
  double get installedMw => _installedMw;
  set installedMw(double value) {
    _installedMw = value;
  }

  double _devexKeur = 0.0;
  double get devexKeur => _devexKeur;
  set devexKeur(double value) {
    _devexKeur = value;
  }

  double _capexTurbineKeur = 0.0;
  double get capexTurbineKeur => _capexTurbineKeur;
  set capexTurbineKeur(double value) {
    _capexTurbineKeur = value;
  }

  double _capexBopKeur = 0.0;
  double get capexBopKeur => _capexBopKeur;
  set capexBopKeur(double value) {
    _capexBopKeur = value;
  }

  double _capexInterKeur = 0.0;
  double get capexInterKeur => _capexInterKeur;
  set capexInterKeur(double value) {
    _capexInterKeur = value;
  }

  double _ncfP50Pct = 0.0;
  double get ncfP50Pct => _ncfP50Pct;
  set ncfP50Pct(double value) {
    _ncfP50Pct = value;
  }

  double _ncfP75Pct = 0.0;
  double get ncfP75Pct => _ncfP75Pct;
  set ncfP75Pct(double value) {
    _ncfP75Pct = value;
  }

  double _availabilityPct = 0.0;
  double get availabilityPct => _availabilityPct;
  set availabilityPct(double value) {
    _availabilityPct = value;
  }

  double _opexYear1Keur = 0.0;
  double get opexYear1Keur => _opexYear1Keur;
  set opexYear1Keur(double value) {
    _opexYear1Keur = value;
  }

  double _ipcPct = 0.0;
  double get ipcPct => _ipcPct;
  set ipcPct(double value) {
    _ipcPct = value;
  }

  double _waccPct = 0.0;
  double get waccPct => _waccPct;
  set waccPct(double value) {
    _waccPct = value;
  }

  double _ppaPriceEurMwh = 0.0;
  double get ppaPriceEurMwh => _ppaPriceEurMwh;
  set ppaPriceEurMwh(double value) {
    _ppaPriceEurMwh = value;
  }

  double _ppaVolumePct = 0.0;
  double get ppaVolumePct => _ppaVolumePct;
  set ppaVolumePct(double value) {
    _ppaVolumePct = value;
  }

  double _merchantPriceEurMwh = 0.0;
  double get merchantPriceEurMwh => _merchantPriceEurMwh;
  set merchantPriceEurMwh(double value) {
    _merchantPriceEurMwh = value;
  }

  double _debtInterestRatePct = 0.0;
  double get debtInterestRatePct => _debtInterestRatePct;
  set debtInterestRatePct(double value) {
    _debtInterestRatePct = value;
  }

  double _targetDscrContracted = 0.0;
  double get targetDscrContracted => _targetDscrContracted;
  set targetDscrContracted(double value) {
    _targetDscrContracted = value;
  }

  double _targetDscrMerchant = 0.0;
  double get targetDscrMerchant => _targetDscrMerchant;
  set targetDscrMerchant(double value) {
    _targetDscrMerchant = value;
  }

  double _targetGearingPct = 0.0;
  double get targetGearingPct => _targetGearingPct;
  set targetGearingPct(double value) {
    _targetGearingPct = value;
  }

  double _projectIrrPct = 0.0;
  double get projectIrrPct => _projectIrrPct;
  set projectIrrPct(double value) {
    _projectIrrPct = value;
  }

  double _equityIrrPct = 0.0;
  double get equityIrrPct => _equityIrrPct;
  set equityIrrPct(double value) {
    _equityIrrPct = value;
  }

  double _projectNpvKeur = 0.0;
  double get projectNpvKeur => _projectNpvKeur;
  set projectNpvKeur(double value) {
    _projectNpvKeur = value;
  }

  double _lcoeEurMwh = 0.0;
  double get lcoeEurMwh => _lcoeEurMwh;
  set lcoeEurMwh(double value) {
    _lcoeEurMwh = value;
  }

  double _minDscr = 0.0;
  double get minDscr => _minDscr;
  set minDscr(double value) {
    _minDscr = value;
  }

  double _avgDscr = 0.0;
  double get avgDscr => _avgDscr;
  set avgDscr(double value) {
    _avgDscr = value;
  }

  double _debtKeur = 0.0;
  double get debtKeur => _debtKeur;
  set debtKeur(double value) {
    _debtKeur = value;
  }

  double _equityKeur = 0.0;
  double get equityKeur => _equityKeur;
  set equityKeur(double value) {
    _equityKeur = value;
  }

  double _gearingPct = 0.0;
  double get gearingPct => _gearingPct;
  set gearingPct(double value) {
    _gearingPct = value;
  }

  String _bindingConstraint = '';
  String get bindingConstraint => _bindingConstraint;
  set bindingConstraint(String value) {
    _bindingConstraint = value;
  }

  int _debtTenorYears = 0;
  int get debtTenorYears => _debtTenorYears;
  set debtTenorYears(int value) {
    _debtTenorYears = value;
  }

  int _projectLifeYears = 0;
  int get projectLifeYears => _projectLifeYears;
  set projectLifeYears(int value) {
    _projectLifeYears = value;
  }

  int _ppaTenorYears = 0;
  int get ppaTenorYears => _ppaTenorYears;
  set ppaTenorYears(int value) {
    _ppaTenorYears = value;
  }

  List<double> _cfadsKeur = [];
  List<double> get cfadsKeur => _cfadsKeur;
  set cfadsKeur(List<double> value) {
    _cfadsKeur = value;
  }

  void addToCfadsKeur(double value) {
    cfadsKeur.add(value);
  }

  void removeFromCfadsKeur(double value) {
    cfadsKeur.remove(value);
  }

  void removeAtIndexFromCfadsKeur(int index) {
    cfadsKeur.removeAt(index);
  }

  void updateCfadsKeurAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    cfadsKeur[index] = updateFn(_cfadsKeur[index]);
  }

  void insertAtIndexInCfadsKeur(int index, double value) {
    cfadsKeur.insert(index, value);
  }

  List<double> _debtSvc = [];
  List<double> get debtSvc => _debtSvc;
  set debtSvc(List<double> value) {
    _debtSvc = value;
  }

  void addToDebtSvc(double value) {
    debtSvc.add(value);
  }

  void removeFromDebtSvc(double value) {
    debtSvc.remove(value);
  }

  void removeAtIndexFromDebtSvc(int index) {
    debtSvc.removeAt(index);
  }

  void updateDebtSvcAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    debtSvc[index] = updateFn(_debtSvc[index]);
  }

  void insertAtIndexInDebtSvc(int index, double value) {
    debtSvc.insert(index, value);
  }

  List<double> _dscr = [];
  List<double> get dscr => _dscr;
  set dscr(List<double> value) {
    _dscr = value;
  }

  void addToDscr(double value) {
    dscr.add(value);
  }

  void removeFromDscr(double value) {
    dscr.remove(value);
  }

  void removeAtIndexFromDscr(int index) {
    dscr.removeAt(index);
  }

  void updateDscrAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    dscr[index] = updateFn(_dscr[index]);
  }

  void insertAtIndexInDscr(int index, double value) {
    dscr.insert(index, value);
  }

  List<double> _equityCfKeur = [];
  List<double> get equityCfKeur => _equityCfKeur;
  set equityCfKeur(List<double> value) {
    _equityCfKeur = value;
  }

  void addToEquityCfKeur(double value) {
    equityCfKeur.add(value);
  }

  void removeFromEquityCfKeur(double value) {
    equityCfKeur.remove(value);
  }

  void removeAtIndexFromEquityCfKeur(int index) {
    equityCfKeur.removeAt(index);
  }

  void updateEquityCfKeurAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    equityCfKeur[index] = updateFn(_equityCfKeur[index]);
  }

  void insertAtIndexInEquityCfKeur(int index, double value) {
    equityCfKeur.insert(index, value);
  }

  List<double> _openDebt = [];
  List<double> get openDebt => _openDebt;
  set openDebt(List<double> value) {
    _openDebt = value;
  }

  void addToOpenDebt(double value) {
    openDebt.add(value);
  }

  void removeFromOpenDebt(double value) {
    openDebt.remove(value);
  }

  void removeAtIndexFromOpenDebt(int index) {
    openDebt.removeAt(index);
  }

  void updateOpenDebtAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    openDebt[index] = updateFn(_openDebt[index]);
  }

  void insertAtIndexInOpenDebt(int index, double value) {
    openDebt.insert(index, value);
  }

  List<double> _opexKeur = [];
  List<double> get opexKeur => _opexKeur;
  set opexKeur(List<double> value) {
    _opexKeur = value;
  }

  void addToOpexKeur(double value) {
    opexKeur.add(value);
  }

  void removeFromOpexKeur(double value) {
    opexKeur.remove(value);
  }

  void removeAtIndexFromOpexKeur(int index) {
    opexKeur.removeAt(index);
  }

  void updateOpexKeurAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    opexKeur[index] = updateFn(_opexKeur[index]);
  }

  void insertAtIndexInOpexKeur(int index, double value) {
    opexKeur.insert(index, value);
  }

  List<double> _p50Mwh = [];
  List<double> get p50Mwh => _p50Mwh;
  set p50Mwh(List<double> value) {
    _p50Mwh = value;
  }

  void addToP50Mwh(double value) {
    p50Mwh.add(value);
  }

  void removeFromP50Mwh(double value) {
    p50Mwh.remove(value);
  }

  void removeAtIndexFromP50Mwh(int index) {
    p50Mwh.removeAt(index);
  }

  void updateP50MwhAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    p50Mwh[index] = updateFn(_p50Mwh[index]);
  }

  void insertAtIndexInP50Mwh(int index, double value) {
    p50Mwh.insert(index, value);
  }

  List<double> _totalRevKeur = [];
  List<double> get totalRevKeur => _totalRevKeur;
  set totalRevKeur(List<double> value) {
    _totalRevKeur = value;
  }

  void addToTotalRevKeur(double value) {
    totalRevKeur.add(value);
  }

  void removeFromTotalRevKeur(double value) {
    totalRevKeur.remove(value);
  }

  void removeAtIndexFromTotalRevKeur(int index) {
    totalRevKeur.removeAt(index);
  }

  void updateTotalRevKeurAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    totalRevKeur[index] = updateFn(_totalRevKeur[index]);
  }

  void insertAtIndexInTotalRevKeur(int index, double value) {
    totalRevKeur.insert(index, value);
  }

  List<int> _years = [];
  List<int> get years => _years;
  set years(List<int> value) {
    _years = value;
  }

  void addToYears(int value) {
    years.add(value);
  }

  void removeFromYears(int value) {
    years.remove(value);
  }

  void removeAtIndexFromYears(int index) {
    years.removeAt(index);
  }

  void updateYearsAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    years[index] = updateFn(_years[index]);
  }

  void insertAtIndexInYears(int index, int value) {
    years.insert(index, value);
  }

  List<double> _principal = [];
  List<double> get principal => _principal;
  set principal(List<double> value) {
    _principal = value;
  }

  void addToPrincipal(double value) {
    principal.add(value);
  }

  void removeFromPrincipal(double value) {
    principal.remove(value);
  }

  void removeAtIndexFromPrincipal(int index) {
    principal.removeAt(index);
  }

  void updatePrincipalAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    principal[index] = updateFn(_principal[index]);
  }

  void insertAtIndexInPrincipal(int index, double value) {
    principal.insert(index, value);
  }

  List<double> _interest = [];
  List<double> get interest => _interest;
  set interest(List<double> value) {
    _interest = value;
  }

  void addToInterest(double value) {
    interest.add(value);
  }

  void removeFromInterest(double value) {
    interest.remove(value);
  }

  void removeAtIndexFromInterest(int index) {
    interest.removeAt(index);
  }

  void updateInterestAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    interest[index] = updateFn(_interest[index]);
  }

  void insertAtIndexInInterest(int index, double value) {
    interest.insert(index, value);
  }

  List<double> _closeDebt = [];
  List<double> get closeDebt => _closeDebt;
  set closeDebt(List<double> value) {
    _closeDebt = value;
  }

  void addToCloseDebt(double value) {
    closeDebt.add(value);
  }

  void removeFromCloseDebt(double value) {
    closeDebt.remove(value);
  }

  void removeAtIndexFromCloseDebt(int index) {
    closeDebt.removeAt(index);
  }

  void updateCloseDebtAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    closeDebt[index] = updateFn(_closeDebt[index]);
  }

  void insertAtIndexInCloseDebt(int index, double value) {
    closeDebt.insert(index, value);
  }

  String _projectName = '';
  String get projectName => _projectName;
  set projectName(String value) {
    _projectName = value;
  }

  double _irrWaccRatio = 0.0;
  double get irrWaccRatio => _irrWaccRatio;
  set irrWaccRatio(double value) {
    _irrWaccRatio = value;
  }

  double _npvCapexRatio = 0.0;
  double get npvCapexRatio => _npvCapexRatio;
  set npvCapexRatio(double value) {
    _npvCapexRatio = value;
  }

  double _paybackYears = 0.0;
  double get paybackYears => _paybackYears;
  set paybackYears(double value) {
    _paybackYears = value;
  }

  double _contractedNpvKeur = 0.0;
  double get contractedNpvKeur => _contractedNpvKeur;
  set contractedNpvKeur(double value) {
    _contractedNpvKeur = value;
  }

  String _technology = '';
  String get technology => _technology;
  set technology(String value) {
    _technology = value;
  }

  double _degradationPct = 0.0;
  double get degradationPct => _degradationPct;
  set degradationPct(double value) {
    _degradationPct = value;
  }

  String _projectDescription = '';
  String get projectDescription => _projectDescription;
  set projectDescription(String value) {
    _projectDescription = value;
  }

  String _curtailmentMode = '';
  String get curtailmentMode => _curtailmentMode;
  set curtailmentMode(String value) {
    _curtailmentMode = value;
  }

  double _curtailmentRatePct = 0.0;
  double get curtailmentRatePct => _curtailmentRatePct;
  set curtailmentRatePct(double value) {
    _curtailmentRatePct = value;
  }

  bool _ppaCoversNegativeHours = true;
  bool get ppaCoversNegativeHours => _ppaCoversNegativeHours;
  set ppaCoversNegativeHours(bool value) {
    _ppaCoversNegativeHours = value;
  }

  double _spotPriceGrowthPct = 1.5;
  double get spotPriceGrowthPct => _spotPriceGrowthPct;
  set spotPriceGrowthPct(double value) {
    _spotPriceGrowthPct = value;
  }

  List<double> _generationProfile = [];
  List<double> get generationProfile => _generationProfile;
  set generationProfile(List<double> value) {
    _generationProfile = value;
  }

  void addToGenerationProfile(double value) {
    generationProfile.add(value);
  }

  void removeFromGenerationProfile(double value) {
    generationProfile.remove(value);
  }

  void removeAtIndexFromGenerationProfile(int index) {
    generationProfile.removeAt(index);
  }

  void updateGenerationProfileAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    generationProfile[index] = updateFn(_generationProfile[index]);
  }

  void insertAtIndexInGenerationProfile(int index, double value) {
    generationProfile.insert(index, value);
  }

  List<double> _priceProfile = [];
  List<double> get priceProfile => _priceProfile;
  set priceProfile(List<double> value) {
    _priceProfile = value;
  }

  void addToPriceProfile(double value) {
    priceProfile.add(value);
  }

  void removeFromPriceProfile(double value) {
    priceProfile.remove(value);
  }

  void removeAtIndexFromPriceProfile(int index) {
    priceProfile.removeAt(index);
  }

  void updatePriceProfileAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    priceProfile[index] = updateFn(_priceProfile[index]);
  }

  void insertAtIndexInPriceProfile(int index, double value) {
    priceProfile.insert(index, value);
  }

  String _templateUrlGeneration =
      'https://firebasestorage.googleapis.com/v0/b/wind-financial-model.firebasestorage.app/o/Templates%2Fplantilla_generacion_solar_100MW.csv?alt=media';
  String get templateUrlGeneration => _templateUrlGeneration;
  set templateUrlGeneration(String value) {
    _templateUrlGeneration = value;
  }

  String _templateUrlPrices =
      'https://firebasestorage.googleapis.com/v0/b/wind-financial-model.firebasestorage.app/o/Templates%2Fplantilla_precios_OMIE.csv?alt=media';
  String get templateUrlPrices => _templateUrlPrices;
  set templateUrlPrices(String value) {
    _templateUrlPrices = value;
  }

  bool _generationFileUploaded = false;
  bool get generationFileUploaded => _generationFileUploaded;
  set generationFileUploaded(bool value) {
    _generationFileUploaded = value;
  }

  bool _priceFileUploaded = false;
  bool get priceFileUploaded => _priceFileUploaded;
  set priceFileUploaded(bool value) {
    _priceFileUploaded = value;
  }

  String _parseErrorMessage = '';
  String get parseErrorMessage => _parseErrorMessage;
  set parseErrorMessage(String value) {
    _parseErrorMessage = value;
  }

  DateTime? _lastCalculationDate =
      DateTime.fromMillisecondsSinceEpoch(1784837940000);
  DateTime? get lastCalculationDate => _lastCalculationDate;
  set lastCalculationDate(DateTime? value) {
    _lastCalculationDate = value;
  }

  bool _scenarioLoaded = false;
  bool get scenarioLoaded => _scenarioLoaded;
  set scenarioLoaded(bool value) {
    _scenarioLoaded = value;
  }

  String _selectedScenarioId = '';
  String get selectedScenarioId => _selectedScenarioId;
  set selectedScenarioId(String value) {
    _selectedScenarioId = value;
  }

  List<String> _visibleComparisonRows = [];
  List<String> get visibleComparisonRows => _visibleComparisonRows;
  set visibleComparisonRows(List<String> value) {
    _visibleComparisonRows = value;
  }

  void addToVisibleComparisonRows(String value) {
    visibleComparisonRows.add(value);
  }

  void removeFromVisibleComparisonRows(String value) {
    visibleComparisonRows.remove(value);
  }

  void removeAtIndexFromVisibleComparisonRows(int index) {
    visibleComparisonRows.removeAt(index);
  }

  void updateVisibleComparisonRowsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    visibleComparisonRows[index] = updateFn(_visibleComparisonRows[index]);
  }

  void insertAtIndexInVisibleComparisonRows(int index, String value) {
    visibleComparisonRows.insert(index, value);
  }

  DateTime? _socDate = DateTime.fromMillisecondsSinceEpoch(1784837880000);
  DateTime? get socDate => _socDate;
  set socDate(DateTime? value) {
    _socDate = value;
  }

  DateTime? _codDate = DateTime.fromMillisecondsSinceEpoch(1784837880000);
  DateTime? get codDate => _codDate;
  set codDate(DateTime? value) {
    _codDate = value;
  }

  bool _indexCapexTurbine = false;
  bool get indexCapexTurbine => _indexCapexTurbine;
  set indexCapexTurbine(bool value) {
    _indexCapexTurbine = value;
  }

  bool _indexCapexBop = false;
  bool get indexCapexBop => _indexCapexBop;
  set indexCapexBop(bool value) {
    _indexCapexBop = value;
  }

  bool _indexCapexInterconn = false;
  bool get indexCapexInterconn => _indexCapexInterconn;
  set indexCapexInterconn(bool value) {
    _indexCapexInterconn = value;
  }

  double _installedDCMw = 0.0;
  double get installedDCMw => _installedDCMw;
  set installedDCMw(double value) {
    _installedDCMw = value;
  }

  double _capexEquiposSolaresCentWp = 0.0;
  double get capexEquiposSolaresCentWp => _capexEquiposSolaresCentWp;
  set capexEquiposSolaresCentWp(double value) {
    _capexEquiposSolaresCentWp = value;
  }

  double _capexBoSCentWp = 0.0;
  double get capexBoSCentWp => _capexBoSCentWp;
  set capexBoSCentWp(double value) {
    _capexBoSCentWp = value;
  }

  double _capexIndexedTotalKeur = 0.0;
  double get capexIndexedTotalKeur => _capexIndexedTotalKeur;
  set capexIndexedTotalKeur(double value) {
    _capexIndexedTotalKeur = value;
  }

  double _idcKeur = 0.0;
  double get idcKeur => _idcKeur;
  set idcKeur(double value) {
    _idcKeur = value;
  }

  double _dsraKeur = 0.0;
  double get dsraKeur => _dsraKeur;
  set dsraKeur(double value) {
    _dsraKeur = value;
  }

  double _minDscrBank = 0.0;
  double get minDscrBank => _minDscrBank;
  set minDscrBank(double value) {
    _minDscrBank = value;
  }

  double _avgDscrBank = 0.0;
  double get avgDscrBank => _avgDscrBank;
  set avgDscrBank(double value) {
    _avgDscrBank = value;
  }

  String _opexMode = '';
  String get opexMode => _opexMode;
  set opexMode(String value) {
    _opexMode = value;
  }

  List<double> _opexWtgBands = [];
  List<double> get opexWtgBands => _opexWtgBands;
  set opexWtgBands(List<double> value) {
    _opexWtgBands = value;
  }

  void addToOpexWtgBands(double value) {
    opexWtgBands.add(value);
  }

  void removeFromOpexWtgBands(double value) {
    opexWtgBands.remove(value);
  }

  void removeAtIndexFromOpexWtgBands(int index) {
    opexWtgBands.removeAt(index);
  }

  void updateOpexWtgBandsAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    opexWtgBands[index] = updateFn(_opexWtgBands[index]);
  }

  void insertAtIndexInOpexWtgBands(int index, double value) {
    opexWtgBands.insert(index, value);
  }
}
