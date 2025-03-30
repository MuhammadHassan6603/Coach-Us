import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _memberSince = '';
  String _profilePic = '';

  String get name => _name;
  String get email => _email;
  String get memberSince => _memberSince;
  String get profilePic => _profilePic;

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (userDoc.exists) {
        _name = userDoc['fullName'];
        _email = userDoc['email'];
        _profilePic = prefs.getString('profilePic') ?? '';
        Timestamp createdAt = userDoc['createdAt'];
        DateTime date = createdAt.toDate();
        _memberSince = "${DateFormat('MMMM').format(date)} ${date.year}";
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
