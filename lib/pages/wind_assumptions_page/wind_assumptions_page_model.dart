import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'wind_assumptions_page_widget.dart' show WindAssumptionsPageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WindAssumptionsPageModel
    extends FlutterFlowModel<WindAssumptionsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (CalculateWindModel)] action in Row widget.
  ApiCallResponse? apiResult;
  // Stores action output result for [Custom Action - showReturnHomeDialog] action in Container widget.
  bool? goToHomeScreen;
  // State field(s) for DEVEX widget.
  FocusNode? devexFocusNode;
  TextEditingController? devexTextController;
  String? Function(BuildContext, String?)? devexTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for WTGCAPEX widget.
  FocusNode? wtgcapexFocusNode;
  TextEditingController? wtgcapexTextController;
  String? Function(BuildContext, String?)? wtgcapexTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for BOPCAPEX widget.
  FocusNode? bopcapexFocusNode;
  TextEditingController? bopcapexTextController;
  String? Function(BuildContext, String?)? bopcapexTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for HVCAPEX widget.
  FocusNode? hvcapexFocusNode;
  TextEditingController? hvcapexTextController;
  String? Function(BuildContext, String?)? hvcapexTextControllerValidator;
  // State field(s) for LIFE widget.
  FocusNode? lifeFocusNode;
  TextEditingController? lifeTextController;
  String? Function(BuildContext, String?)? lifeTextControllerValidator;
  // State field(s) for MERCHANT widget.
  FocusNode? merchantFocusNode;
  TextEditingController? merchantTextController;
  String? Function(BuildContext, String?)? merchantTextControllerValidator;
  // State field(s) for PPAPRICE widget.
  FocusNode? ppapriceFocusNode;
  TextEditingController? ppapriceTextController;
  String? Function(BuildContext, String?)? ppapriceTextControllerValidator;
  // State field(s) for PPAVOL widget.
  FocusNode? ppavolFocusNode;
  TextEditingController? ppavolTextController;
  String? Function(BuildContext, String?)? ppavolTextControllerValidator;
  // State field(s) for PPATENOR widget.
  FocusNode? ppatenorFocusNode;
  TextEditingController? ppatenorTextController;
  String? Function(BuildContext, String?)? ppatenorTextControllerValidator;
  // State field(s) for AVAI widget.
  FocusNode? avaiFocusNode;
  TextEditingController? avaiTextController;
  String? Function(BuildContext, String?)? avaiTextControllerValidator;
  // State field(s) for NCF50 widget.
  FocusNode? ncf50FocusNode;
  TextEditingController? ncf50TextController;
  String? Function(BuildContext, String?)? ncf50TextControllerValidator;
  // State field(s) for NCF75 widget.
  FocusNode? ncf75FocusNode;
  TextEditingController? ncf75TextController;
  String? Function(BuildContext, String?)? ncf75TextControllerValidator;
  // State field(s) for IPC widget.
  FocusNode? ipcFocusNode;
  TextEditingController? ipcTextController;
  String? Function(BuildContext, String?)? ipcTextControllerValidator;
  // State field(s) for WACC widget.
  FocusNode? waccFocusNode;
  TextEditingController? waccTextController;
  String? Function(BuildContext, String?)? waccTextControllerValidator;
  // State field(s) for DEBT widget.
  FocusNode? debtFocusNode;
  TextEditingController? debtTextController;
  String? Function(BuildContext, String?)? debtTextControllerValidator;
  // State field(s) for DEBTTENOR widget.
  FocusNode? debttenorFocusNode;
  TextEditingController? debttenorTextController;
  String? Function(BuildContext, String?)? debttenorTextControllerValidator;
  // State field(s) for GEARING widget.
  FocusNode? gearingFocusNode;
  TextEditingController? gearingTextController;
  String? Function(BuildContext, String?)? gearingTextControllerValidator;
  // State field(s) for DSCRMER widget.
  FocusNode? dscrmerFocusNode;
  TextEditingController? dscrmerTextController;
  String? Function(BuildContext, String?)? dscrmerTextControllerValidator;
  // State field(s) for DSCRPPA widget.
  FocusNode? dscrppaFocusNode;
  TextEditingController? dscrppaTextController;
  String? Function(BuildContext, String?)? dscrppaTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    devexFocusNode?.dispose();
    devexTextController?.dispose();

    wtgcapexFocusNode?.dispose();
    wtgcapexTextController?.dispose();

    bopcapexFocusNode?.dispose();
    bopcapexTextController?.dispose();

    hvcapexFocusNode?.dispose();
    hvcapexTextController?.dispose();

    lifeFocusNode?.dispose();
    lifeTextController?.dispose();

    merchantFocusNode?.dispose();
    merchantTextController?.dispose();

    ppapriceFocusNode?.dispose();
    ppapriceTextController?.dispose();

    ppavolFocusNode?.dispose();
    ppavolTextController?.dispose();

    ppatenorFocusNode?.dispose();
    ppatenorTextController?.dispose();

    avaiFocusNode?.dispose();
    avaiTextController?.dispose();

    ncf50FocusNode?.dispose();
    ncf50TextController?.dispose();

    ncf75FocusNode?.dispose();
    ncf75TextController?.dispose();

    ipcFocusNode?.dispose();
    ipcTextController?.dispose();

    waccFocusNode?.dispose();
    waccTextController?.dispose();

    debtFocusNode?.dispose();
    debtTextController?.dispose();

    debttenorFocusNode?.dispose();
    debttenorTextController?.dispose();

    gearingFocusNode?.dispose();
    gearingTextController?.dispose();

    dscrmerFocusNode?.dispose();
    dscrmerTextController?.dispose();

    dscrppaFocusNode?.dispose();
    dscrppaTextController?.dispose();
  }
}
