import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

class Globals {
  const Globals._();

  static final auth = FirebaseAuth.instance;

  static User? get firebaseUser => auth.currentUser;

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static final kNavigatorKey = GlobalKey<NavigatorState>();

  static final kNestedNavigatorKey = GlobalKey<NavigatorState>();

  static final kMainNestedNavigatorKey = GlobalKey<NavigatorState>();

  static final kSearchNestedNavigatorKey = GlobalKey<NavigatorState>();

  static final kMyMediaNestedNavigatorKey = GlobalKey<NavigatorState>();
}
