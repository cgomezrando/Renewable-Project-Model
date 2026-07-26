import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'home_screen_widget.dart' show HomeScreenWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreenModel extends FlutterFlowModel<HomeScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - showNewProjectDialog] action in Container widget.
  bool? dialogConfirmed;
  // Stores action output result for [Custom Action - showNewProjectDialog] action in Container widget.
  bool? dialogResultSolar;
  // Stores action output result for [Custom Action - showNewProjectDialog] action in Container widget.
  bool? dialogResultBESS;
  // Stores action output result for [Custom Action - loadScenario] action in Container widget.
  bool? loaded;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
