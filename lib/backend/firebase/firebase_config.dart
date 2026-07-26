import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCGZaq2_5Wy_tIiwAiZ9iKwIlhDcFIKsVQ",
            authDomain: "wind-financial-model.firebaseapp.com",
            projectId: "wind-financial-model",
            storageBucket: "wind-financial-model.firebasestorage.app",
            messagingSenderId: "490758581438",
            appId: "1:490758581438:web:bb6ec94ffdd6d253dc82ef",
            measurementId: "G-Z0NJ8XK8WF"));
  } else {
    await Firebase.initializeApp();
  }
}
