import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScenariosRecord extends FirestoreRecord {
  ScenariosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "technology" field.
  String? _technology;
  String get technology => _technology ?? '';
  bool hasTechnology() => _technology != null;

  // "createdDate" field.
  DateTime? _createdDate;
  DateTime? get createdDate => _createdDate;
  bool hasCreatedDate() => _createdDate != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "generationProfile" field.
  List<double>? _generationProfile;
  List<double> get generationProfile => _generationProfile ?? const [];
  bool hasGenerationProfile() => _generationProfile != null;

  // "priceProfile" field.
  List<double>? _priceProfile;
  List<double> get priceProfile => _priceProfile ?? const [];
  bool hasPriceProfile() => _priceProfile != null;

  // "assumptions" field.
  String? _assumptions;
  String get assumptions => _assumptions ?? '';
  bool hasAssumptions() => _assumptions != null;

  // "projectName" field.
  String? _projectName;
  String get projectName => _projectName ?? '';
  bool hasProjectName() => _projectName != null;

  // "projectDescription" field.
  String? _projectDescription;
  String get projectDescription => _projectDescription ?? '';
  bool hasProjectDescription() => _projectDescription != null;

  // "scenarioName" field.
  String? _scenarioName;
  String get scenarioName => _scenarioName ?? '';
  bool hasScenarioName() => _scenarioName != null;

  // "outputs" field.
  String? _outputs;
  String get outputs => _outputs ?? '';
  bool hasOutputs() => _outputs != null;

  void _initializeFields() {
    _technology = snapshotData['technology'] as String?;
    _createdDate = snapshotData['createdDate'] as DateTime?;
    _userId = snapshotData['userId'] as String?;
    _generationProfile = getDataList(snapshotData['generationProfile']);
    _priceProfile = getDataList(snapshotData['priceProfile']);
    _assumptions = snapshotData['assumptions'] as String?;
    _projectName = snapshotData['projectName'] as String?;
    _projectDescription = snapshotData['projectDescription'] as String?;
    _scenarioName = snapshotData['scenarioName'] as String?;
    _outputs = snapshotData['outputs'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('scenarios');

  static Stream<ScenariosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ScenariosRecord.fromSnapshot(s));

  static Future<ScenariosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ScenariosRecord.fromSnapshot(s));

  static ScenariosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ScenariosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ScenariosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ScenariosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ScenariosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ScenariosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createScenariosRecordData({
  String? technology,
  DateTime? createdDate,
  String? userId,
  String? assumptions,
  String? projectName,
  String? projectDescription,
  String? scenarioName,
  String? outputs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'technology': technology,
      'createdDate': createdDate,
      'userId': userId,
      'assumptions': assumptions,
      'projectName': projectName,
      'projectDescription': projectDescription,
      'scenarioName': scenarioName,
      'outputs': outputs,
    }.withoutNulls,
  );

  return firestoreData;
}

class ScenariosRecordDocumentEquality implements Equality<ScenariosRecord> {
  const ScenariosRecordDocumentEquality();

  @override
  bool equals(ScenariosRecord? e1, ScenariosRecord? e2) {
    const listEquality = ListEquality();
    return e1?.technology == e2?.technology &&
        e1?.createdDate == e2?.createdDate &&
        e1?.userId == e2?.userId &&
        listEquality.equals(e1?.generationProfile, e2?.generationProfile) &&
        listEquality.equals(e1?.priceProfile, e2?.priceProfile) &&
        e1?.assumptions == e2?.assumptions &&
        e1?.projectName == e2?.projectName &&
        e1?.projectDescription == e2?.projectDescription &&
        e1?.scenarioName == e2?.scenarioName &&
        e1?.outputs == e2?.outputs;
  }

  @override
  int hash(ScenariosRecord? e) => const ListEquality().hash([
        e?.technology,
        e?.createdDate,
        e?.userId,
        e?.generationProfile,
        e?.priceProfile,
        e?.assumptions,
        e?.projectName,
        e?.projectDescription,
        e?.scenarioName,
        e?.outputs
      ]);

  @override
  bool isValidKey(Object? o) => o is ScenariosRecord;
}
