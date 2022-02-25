import 'package:auth_repository/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deposit_firestore/deposit_firestore.dart';
import 'package:editor/src/app/views/app_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:repository/repository.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authRepository = AuthRepository(auth: FirebaseAuth.instance);

  final adapter = FirestoreDepositAdapter(firestore: FirebaseFirestore.instance);
  final projectRepository = ProjectRepository(adapter: adapter);

  runApp(
    Ember8App(
      authRepository: authRepository,
      projectRepository: projectRepository,
    ),
  );
}
