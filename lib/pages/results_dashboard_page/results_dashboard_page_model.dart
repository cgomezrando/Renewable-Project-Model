import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'results_dashboard_page_widget.dart' show ResultsDashboardPageWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResultsDashboardPageModel
    extends FlutterFlowModel<ResultsDashboardPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - saveScenario] action in Container widget.
  String? savedIdTrue;
  // Stores action output result for [Custom Action - showFillDescriptionDialog] action in Container widget.
  String? newDescription;
  // Stores action output result for [Custom Action - saveScenario] action in Container widget.
  String? savedIdFalse;
  // Stores action output result for [Custom Action - showReturnHomeDialog] action in Container widget.
  bool? goToHomeScreen;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
