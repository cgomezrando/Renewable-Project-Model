import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class CalculateWindModelCall {
  static Future<ApiCallResponse> call({
    String? installedMw = '',
    String? devexKeur = '',
    String? capexTurbineKeur = '',
    String? capexBopKeur = '',
    String? capexInterconnectionKeur = '',
    String? ncfP50Pct = '',
    String? ncfP75Pct = '',
    String? availabilityPct = '',
    String? opexYear1Keur = '',
    String? ipcPct = '',
    String? waccPct = '',
    String? ppaPriceEurMwh = '',
    String? ppaTenorYears = '',
    String? ppaVolumePct = '',
    String? merchantPriceEurMwh = '',
    String? projectLifeYears = '',
    String? debtInterestRatePct = '',
    String? debtTenorYears = '',
    String? targetDscrContracted = '',
    String? targetDscrMerchant = '',
    String? targetGearingPct = '',
    String? technology = '',
    String? degradationPct = '',
    String? curtailmentMode = '',
    String? curtailmentRatePct = '',
    String? ppaCoversNegativeHours = '',
    String? spotPriceGrowthPct = '',
    String? socDate = '',
    String? codDate = '',
    bool? indexCapexTurbine,
    bool? indexCapexBop,
    bool? indexCapexInterconn,
    String? opexWtgBandsJson = 'False',
  }) async {
    final ffApiRequestBody = '''
{
  "installed_mw": "${escapeStringForJson(installedMw)}",
  "devex_keur": "${escapeStringForJson(devexKeur)}",
  "capex_turbine_keur": "${escapeStringForJson(capexTurbineKeur)}",
  "capex_bop_keur": "${escapeStringForJson(capexBopKeur)}",
  "capex_interconnection_keur": "${escapeStringForJson(capexInterconnectionKeur)}",
  "ncf_p50_pct": "${escapeStringForJson(ncfP50Pct)}",
  "ncf_p75_pct": "${escapeStringForJson(ncfP75Pct)}",
  "availability_pct": "${escapeStringForJson(availabilityPct)}",
  "opex_year1_keur": "${escapeStringForJson(opexYear1Keur)}",
  "ipc_pct": "${escapeStringForJson(ipcPct)}",
  "wacc_pct": "${escapeStringForJson(waccPct)}",
  "ppa_price_eur_mwh": "${escapeStringForJson(ppaPriceEurMwh)}",
  "ppa_tenor_years": "${escapeStringForJson(ppaTenorYears)}",
  "ppa_volume_pct": "${escapeStringForJson(ppaVolumePct)}",
  "merchant_price_eur_mwh": "${escapeStringForJson(merchantPriceEurMwh)}",
  "project_life_years": "${escapeStringForJson(projectLifeYears)}",
  "debt_interest_rate_pct": "${escapeStringForJson(debtInterestRatePct)}",
  "debt_tenor_years": "${escapeStringForJson(debtTenorYears)}",
  "target_dscr_contracted": "${escapeStringForJson(targetDscrContracted)}",
  "target_dscr_merchant": "${escapeStringForJson(targetDscrMerchant)}",
  "target_gearing_pct": "${escapeStringForJson(targetGearingPct)}",
"technology": "${escapeStringForJson(technology)}",
"degradation_pct": "${escapeStringForJson(degradationPct)}",
"curtailment_mode": "${escapeStringForJson(curtailmentMode)}",
"curtailment_rate_pct": "${escapeStringForJson(curtailmentRatePct)}",
"ppa_covers_negative_hours": "${escapeStringForJson(ppaCoversNegativeHours)}",
"spot_price_growth_pct": "${escapeStringForJson(spotPriceGrowthPct)}",
"soc_date": "${escapeStringForJson(socDate)}",
"cod_date": "${escapeStringForJson(codDate)}",
"index_capex_turbine": "${indexCapexTurbine}",
"index_capex_bop": "${indexCapexBop}",
"index_capex_inter": "${indexCapexInterconn}",
"opex_wtg_bands": "${escapeStringForJson(opexWtgBandsJson)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CalculateWindModel',
      apiUrl: 'https://renewable-model-auybcyvgja-ew.a.run.app',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<double>? cfadskeur(dynamic response) => (getJsonField(
        response,
        r'''$.annual.cfads_keur''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? debtsvc(dynamic response) => (getJsonField(
        response,
        r'''$.annual.debt_svc''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? dscr(dynamic response) => (getJsonField(
        response,
        r'''$.annual.dscr''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? equitycfkeur(dynamic response) => (getJsonField(
        response,
        r'''$.annual.equity_cf_keur''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? opendebt(dynamic response) => (getJsonField(
        response,
        r'''$.annual.open_debt''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? opexkeur(dynamic response) => (getJsonField(
        response,
        r'''$.annual.opex_keur''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? p50mwh(dynamic response) => (getJsonField(
        response,
        r'''$.annual.p50_mwh''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<int>? years(dynamic response) => (getJsonField(
        response,
        r'''$.annual.years''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<double>? totalrevkeur(dynamic response) => (getJsonField(
        response,
        r'''$.annual.total_rev_keur''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static double? projectirrpct(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.outputs.project_irr_pct''',
      ));
  static double? equityirrpct(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.outputs.equity_irr_pct''',
      ));
  static double? projectnpvkeur(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.outputs.project_npv_keur''',
      ));
  static double? lcoeeurmwh(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.outputs.lcoe_eur_mwh''',
      ));
  static double? mindscr(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.outputs.min_dscr''',
      ));
  static double? avgdscr(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.outputs.avg_dscr''',
      ));
  static double? debtkeur(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.financing.debt_keur''',
      ));
  static double? equitykeur(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.financing.equity_keur''',
      ));
  static double? gearingpct(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.financing.gearing_pct''',
      ));
  static String? bindingconstraint(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.financing.binding_constraint''',
      ));
  static List? principal(dynamic response) => getJsonField(
        response,
        r'''$.annual.principal''',
        true,
      ) as List?;
  static List? interest(dynamic response) => getJsonField(
        response,
        r'''$.annual.interest''',
        true,
      ) as List?;
  static List? closeDebt(dynamic response) => getJsonField(
        response,
        r'''$.annual.close_debt''',
        true,
      ) as List?;
  static dynamic irrWaccRatio(dynamic response) => getJsonField(
        response,
        r'''$.outputs.irr_wacc_ratio''',
      );
  static dynamic npvCapexRatio(dynamic response) => getJsonField(
        response,
        r'''$.outputs.npv_capex_ratio''',
      );
  static dynamic paybackYears(dynamic response) => getJsonField(
        response,
        r'''$.outputs.payback_years''',
      );
  static dynamic contractedNpvKeur(dynamic response) => getJsonField(
        response,
        r'''$.outputs.contracted_npv_keur''',
      );
  static dynamic capexIndexedTotalKeur(dynamic response) => getJsonField(
        response,
        r'''$.financing.capex_indexed_total_keur''',
      );
  static dynamic idcKeur(dynamic response) => getJsonField(
        response,
        r'''$.financing.idc_keur''',
      );
  static dynamic dsraKeur(dynamic response) => getJsonField(
        response,
        r'''$.financing.dsra_keur''',
      );
  static dynamic minDscrBank(dynamic response) => getJsonField(
        response,
        r'''$.outputs.min_dscr_bank''',
      );
  static dynamic avgDscrBank(dynamic response) => getJsonField(
        response,
        r'''$.outputs.avg_dscr_bank''',
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
