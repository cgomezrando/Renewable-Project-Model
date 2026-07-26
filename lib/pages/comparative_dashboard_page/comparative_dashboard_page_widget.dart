import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comparative_dashboard_page_model.dart';
export 'comparative_dashboard_page_model.dart';

class ComparativeDashboardPageWidget extends StatefulWidget {
  const ComparativeDashboardPageWidget({super.key});

  static String routeName = 'ComparativeDashboardPage';
  static String routePath = '/comparativeDashboardPage';

  @override
  State<ComparativeDashboardPageWidget> createState() =>
      _ComparativeDashboardPageWidgetState();
}

class _ComparativeDashboardPageWidgetState
    extends State<ComparativeDashboardPageWidget> {
  late ComparativeDashboardPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComparativeDashboardPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'ComparativeDashboardPage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF5F8FF),
            body: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/ChatGPT_Image_Jul_18,_2026,_07_35_42_PM.png',
                      ).image,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: custom_widgets.ScenarioComparisonTable(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
