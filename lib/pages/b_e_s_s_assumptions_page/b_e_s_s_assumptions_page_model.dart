import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'b_e_s_s_assumptions_page_widget.dart' show BESSAssumptionsPageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BESSAssumptionsPageModel
    extends FlutterFlowModel<BESSAssumptionsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - showReturnHomeDialog] action in Container widget.
  bool? goToHomeScreen;
  // State field(s) for MW widget.
  FocusNode? mwFocusNode1;
  TextEditingController? mwTextController1;
  String? Function(BuildContext, String?)? mwTextController1Validator;
  // State field(s) for MW widget.
  FocusNode? mwFocusNode2;
  TextEditingController? mwTextController2;
  String? Function(BuildContext, String?)? mwTextController2Validator;
  // State field(s) for DEVEX widget.
  FocusNode? devexFocusNode;
  TextEditingController? devexTextController;
  String? Function(BuildContext, String?)? devexTextControllerValidator;
  // State field(s) for WTGCAPEX widget.
  FocusNode? wtgcapexFocusNode;
  TextEditingController? wtgcapexTextController;
  String? Function(BuildContext, String?)? wtgcapexTextControllerValidator;
  // State field(s) for BOPCAPEX widget.
  FocusNode? bopcapexFocusNode;
  TextEditingController? bopcapexTextController;
  String? Function(BuildContext, String?)? bopcapexTextControllerValidator;
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
  FocusNode? ppatenorFocusNode1;
  TextEditingController? ppatenorTextController1;
  String? Function(BuildContext, String?)? ppatenorTextController1Validator;
  // State field(s) for PPATENOR widget.
  FocusNode? ppatenorFocusNode2;
  TextEditingController? ppatenorTextController2;
  String? Function(BuildContext, String?)? ppatenorTextController2Validator;
  // State field(s) for AVAI widget.
  FocusNode? avaiFocusNode;
  TextEditingController? avaiTextController;
  String? Function(BuildContext, String?)? avaiTextControllerValidator;
  // State field(s) for NCF50 widget.
  FocusNode? ncf50FocusNode;
  TextEditingController? ncf50TextController;
  String? Function(BuildContext, String?)? ncf50TextControllerValidator;
  // State field(s) for NCF90 widget.
  FocusNode? ncf90FocusNode;
  TextEditingController? ncf90TextController;
  String? Function(BuildContext, String?)? ncf90TextControllerValidator;
  // State field(s) for OPEX widget.
  FocusNode? opexFocusNode;
  TextEditingController? opexTextController;
  String? Function(BuildContext, String?)? opexTextControllerValidator;
  // State field(s) for IPC widget.
  FocusNode? ipcFocusNode;
  TextEditingController? ipcTextController;
  String? Function(BuildContext, String?)? ipcTextControllerValidator;
  // State field(s) for WACC widget.
  FocusNode? waccFocusNode1;
  TextEditingController? waccTextController1;
  String? Function(BuildContext, String?)? waccTextController1Validator;
  // State field(s) for WACC widget.
  FocusNode? waccFocusNode2;
  TextEditingController? waccTextController2;
  String? Function(BuildContext, String?)? waccTextController2Validator;
  // State field(s) for DEBT widget.
  FocusNode? debtFocusNode;
  TextEditingController? debtTextController;
  String? Function(BuildContext, String?)? debtTextControllerValidator;
  // State field(s) for DEBTTENOR widget.
  FocusNode? debttenorFocusNode;
  TextEditingController? debttenorTextController;
  String? Function(BuildContext, String?)? debttenorTextControllerValidator;
  // State field(s) for GEARING widget.
  FocusNode? gearingFocusNode1;
  TextEditingController? gearingTextController1;
  String? Function(BuildContext, String?)? gearingTextController1Validator;
  // State field(s) for DSCRMER widget.
  FocusNode? dscrmerFocusNode;
  TextEditingController? dscrmerTextController;
  String? Function(BuildContext, String?)? dscrmerTextControllerValidator;
  // State field(s) for GEARING widget.
  FocusNode? gearingFocusNode2;
  TextEditingController? gearingTextController2;
  String? Function(BuildContext, String?)? gearingTextController2Validator;
  // State field(s) for GEARING widget.
  FocusNode? gearingFocusNode3;
  TextEditingController? gearingTextController3;
  String? Function(BuildContext, String?)? gearingTextController3Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    mwFocusNode1?.dispose();
    mwTextController1?.dispose();

    mwFocusNode2?.dispose();
    mwTextController2?.dispose();

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

    ppatenorFocusNode1?.dispose();
    ppatenorTextController1?.dispose();

    ppatenorFocusNode2?.dispose();
    ppatenorTextController2?.dispose();

    avaiFocusNode?.dispose();
    avaiTextController?.dispose();

    ncf50FocusNode?.dispose();
    ncf50TextController?.dispose();

    ncf90FocusNode?.dispose();
    ncf90TextController?.dispose();

    opexFocusNode?.dispose();
    opexTextController?.dispose();

    ipcFocusNode?.dispose();
    ipcTextController?.dispose();

    waccFocusNode1?.dispose();
    waccTextController1?.dispose();

    waccFocusNode2?.dispose();
    waccTextController2?.dispose();

    debtFocusNode?.dispose();
    debtTextController?.dispose();

    debttenorFocusNode?.dispose();
    debttenorTextController?.dispose();

    gearingFocusNode1?.dispose();
    gearingTextController1?.dispose();

    dscrmerFocusNode?.dispose();
    dscrmerTextController?.dispose();

    gearingFocusNode2?.dispose();
    gearingTextController2?.dispose();

    gearingFocusNode3?.dispose();
    gearingTextController3?.dispose();
  }
}
