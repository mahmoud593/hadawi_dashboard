
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptions implements Exception {

  FirebaseAuthException firebaseAuthException;

  FirebaseAuthExceptions({required this.firebaseAuthException});

}

class FireStoreException implements Exception {

  FirebaseException firebaseException;

  FireStoreException({required this.firebaseException});

}
