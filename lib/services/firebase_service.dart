import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  User? get currentUser => _auth.currentUser;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> deleteUserData(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // Add this method to FirebaseService
Future<void> deleteUserAccount() async {
  try {
    await _auth.currentUser?.delete();
  } catch (e) {
    // If error is about requiring recent authentication
    if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
      // You should ideally re-authenticate here, but since you're signing out anyway
      // just throw a more descriptive error
      throw 'Session expired. Please log in again before deleting your account.';
    } else {
      rethrow;
    }
  }
}
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? fcmToken = await _messaging.getToken();

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
        'tokens': fcmToken != null ? [fcmToken] : [],
        'profilePic':null,
        'profileCompleted': false,
      });

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserProfile({
    required Map<String, dynamic> userData,
  }) async {
    try {
      String uid = currentUser!.uid;
      await _firestore.collection('users').doc(uid).update(userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFCMToken() async {
    if (currentUser != null) {
      String? token = await _messaging.getToken();
      if (token != null) {
        await _firestore.collection('users').doc(currentUser!.uid).update({
          'tokens': FieldValue.arrayUnion([token]),
        });
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
