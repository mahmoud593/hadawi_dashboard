import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hadawi_dathboard/features/auth/data/model/emil_pass_model.dart';
import 'package:hadawi_dathboard/features/auth/data/model/user_model.dart';
import 'package:hadawi_dathboard/utiles/error_handling/exceptions/exceptions.dart';
import 'package:hadawi_dathboard/utiles/shared_preferences/shared_preference.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user == null) {
        throw FireStoreException(
          firebaseException: FirebaseAuthException(
            code: "user-not-found",
            message: "No user found with this email.",
          ),
        );
      }

      debugPrint("User ID: ${user.uid}");
      await getUserData(uId: user.uid);
    } on FirebaseAuthException catch (e) {
      throw FireStoreException(firebaseException: e);
    } catch (e) {
      debugPrint("Unexpected error during login: $e");
      throw FireStoreException(
        firebaseException: FirebaseAuthException(
          code: "unknown-error",
          message: "An unexpected error occurred.",
        ),
      );
    }
  }

  Future<void> saveUserData({
    required String email,
    required String name,
    required String uId,
  }) async {
    try {
      UserModel userModel = UserModel(
        email: email,
        name: name,
        uId: uId,
      );

      await _firestore.collection('users').doc(uId).set(userModel.toJson());
    } catch (e) {
      debugPrint("Error saving user data: $e");
      throw FireStoreException(
        firebaseException: FirebaseAuthException(
          code: "save-user-error",
          message: "Failed to save user data.",
        ),
      );
    }
  }

  Future<UserModel> getUserData({required String uId}) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('admin').doc(uId).get();

      if (!userDoc.exists || userDoc.data() == null) {
        throw FireStoreException(
          firebaseException: FirebaseAuthException(
            code: "user-data-not-found",
            message: "User data not found in Firestore.",
          ),
        );
      }

      UserModel userModel =
          UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

      UserDataFromStorage.setUserName(userModel.name);
      UserDataFromStorage.setEmail(userModel.email);
      UserDataFromStorage.setUid(userModel.uId);

      return userModel;
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      throw FireStoreException(
        firebaseException: FirebaseAuthException(
          code: "fetch-user-error",
          message: "Failed to fetch user data.",
        ),
      );
    }
  }

  Future<EmailPassModel?> loginWithEmailPass({
    required String email,
    required String password,
  }) async {
    try {
      var querySnapshot = await _firestore
          .collection("admin")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      var userDoc = querySnapshot.docs.first;
      var userData = userDoc.data();
      if (userData['password'] == password) {
        return EmailPassModel.fromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();

      // مسح بيانات المستخدم المخزنة محليًا بعد تسجيل الخروج
      await UserDataFromStorage.setUid('');
      await UserDataFromStorage.setUserName('');
      await UserDataFromStorage.setEmail('');
    } on FirebaseAuthException catch (e) {
      throw FireStoreException(firebaseException: e);
    } catch (e) {
      debugPrint("Error during logout: $e");
      throw FireStoreException(
        firebaseException: FirebaseAuthException(
          code: "logout-error",
          message: "Failed to logout.",
        ),
      );
    }
  }
}
