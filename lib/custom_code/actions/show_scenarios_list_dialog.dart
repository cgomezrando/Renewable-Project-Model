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
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> showScenariosListDialog(BuildContext context) async {
  final Color accentColor = const Color(0xFF2563EB);
  final Color accentBg = const Color(0xFFDBEAFE);

  // Reset del ID seleccionado al abrir
  FFAppState().update(() {
    FFAppState().selectedScenarioId = '';
  });

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext ctx) {
      return StatefulBuilder(
        builder: (ctx, setLocal) {
          // Query en vivo — se actualiza al borrar sin reabrir
          final stream = ScenariosRecord.collection
              .where('userId', isEqualTo: currentUserUid)
              .orderBy('createdDate', descending: true)
              .snapshots();

          String? confirmingDeleteId; // Fila con confirmación pendiente

          return StatefulBuilder(
            builder: (ctx, setInner) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 560,
                constraints: const BoxConstraints(maxHeight: 700),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A0F172A),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentBg,
                        ),
                        child: Center(
                          child: Icon(Icons.folder_open,
                              size: 48, color: accentColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Mis escenarios',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Selecciona un escenario guardado para cargar sus datos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Lista con StreamBuilder
                    Flexible(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: accentColor),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return _buildEmpty(
                              icon: Icons.error_outline,
                              iconColor: const Color(0xFFDC2626),
                              iconBg: const Color(0xFFFEE2E2),
                              title: 'Error al cargar',
                              message:
                                  'No se pudieron descargar los escenarios. Comprueba tu conexión a Internet o asegúrate de que tienes al menos un escenario guardado.',
                            );
                          }
                          final docs = snapshot.data?.docs ?? [];
                          if (docs.isEmpty) {
                            return _buildEmpty(
                              icon: Icons.inbox,
                              iconColor: const Color(0xFF64748B),
                              iconBg: const Color(0xFFF1F5F9),
                              title: 'Sin escenarios guardados',
                              message:
                                  'Aún no has guardado ningún escenario. Al terminar un análisis, pulsa el botón de guardar para conservarlo.',
                            );
                          }

                          return SingleChildScrollView(
                            child: Column(
                              children: docs.map((doc) {
                                final d = doc.data() as Map<String, dynamic>;
                                final id = doc.id;
                                final projectName =
                                    (d['projectName'] ?? '') as String;
                                final projectDescription =
                                    (d['projectDescription'] ?? '') as String;
                                final technology =
                                    ((d['technology'] ?? '') as String)
                                        .toLowerCase();
                                final createdRaw = d['createdDate'];
                                final DateTime? createdDate =
                                    createdRaw is Timestamp
                                        ? createdRaw.toDate()
                                        : null;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: _buildScenarioTile(
                                    id: id,
                                    projectName: projectName,
                                    projectDescription: projectDescription,
                                    technology: technology,
                                    createdDate: createdDate,
                                    accentColor: accentColor,
                                    confirmingDeleteId: confirmingDeleteId,
                                    onTapLoad: () {
                                      FFAppState().update(() {
                                        FFAppState().selectedScenarioId = id;
                                      });
                                      Navigator.of(ctx, rootNavigator: true)
                                          .pop();
                                    },
                                    onRequestDelete: () {
                                      setInner(() {
                                        confirmingDeleteId = id;
                                      });
                                    },
                                    onCancelDelete: () {
                                      setInner(() {
                                        confirmingDeleteId = null;
                                      });
                                    },
                                    onConfirmDelete: () async {
                                      try {
                                        await ScenariosRecord.collection
                                            .doc(id)
                                            .delete();
                                      } catch (_) {}
                                      setInner(() {
                                        confirmingDeleteId = null;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(ctx, rootNavigator: true).pop();
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: const Center(
                                child: Text(
                                  'Cerrar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildScenarioTile({
  required String id,
  required String projectName,
  required String projectDescription,
  required String technology,
  required DateTime? createdDate,
  required Color accentColor,
  required String? confirmingDeleteId,
  required VoidCallback onTapLoad,
  required VoidCallback onRequestDelete,
  required VoidCallback onCancelDelete,
  required VoidCallback onConfirmDelete,
}) {
  IconData techIcon;
  Color techColor;
  Color techBg;
  switch (technology) {
    case 'wind':
      techIcon = Icons.air;
      techColor = const Color(0xFF2563EB);
      techBg = const Color(0xFFDBEAFE);
      break;
    case 'solar':
      techIcon = Icons.wb_sunny;
      techColor = const Color(0xFFF59E0B);
      techBg = const Color(0xFFFEF3C7);
      break;
    case 'bess':
      techIcon = Icons.battery_charging_full;
      techColor = const Color(0xFF16A34A);
      techBg = const Color(0xFFDCFCE7);
      break;
    default:
      techIcon = Icons.insert_drive_file;
      techColor = const Color(0xFF64748B);
      techBg = const Color(0xFFF1F5F9);
  }

  final bool confirming = confirmingDeleteId == id;

  return InkWell(
    onTap: confirming ? null : onTapLoad,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: techBg),
            child: Center(child: Icon(techIcon, size: 20, color: techColor)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectName.isEmpty ? '(Sin nombre)' : projectName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (projectDescription.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    projectDescription,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (createdDate != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(createdDate),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (!confirming)
            InkWell(
              onTap: onRequestDelete,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
              ),
            )
          else
            Row(
              children: [
                InkWell(
                  onTap: onCancelDelete,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                InkWell(
                  onTap: onConfirmDelete,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDC2626),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Borrar',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}

Widget _buildEmpty({
  required IconData icon,
  required Color iconColor,
  required Color iconBg,
  required String title,
  required String message,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
          child: Center(child: Icon(icon, size: 36, color: iconColor)),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

String _formatDate(DateTime d) {
  const meses = [
    'ene',
    'feb',
    'mar',
    'abr',
    'may',
    'jun',
    'jul',
    'ago',
    'sep',
    'oct',
    'nov',
    'dic'
  ];
  final hh = d.hour.toString().padLeft(2, '0');
  final mm = d.minute.toString().padLeft(2, '0');
  return '${d.day} ${meses[d.month - 1]} ${d.year} · $hh:$mm';
}
