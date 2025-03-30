import 'package:didpool/bottom_bar/bottom_bar.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        _nameController.text = userDoc['fullName'] ?? '';
        _emailController.text = userDoc['email'] ?? '';
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'fullName': _nameController.text,
        'email': _emailController.text,
      });
    }
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!',style: TextStyle(color: Colors.white), ),
          backgroundColor: Colors.green,
        ),
      );
    Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomBarScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff282335),
        centerTitle: true,
      ),
      backgroundColor: Color(0xff282335),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.grey,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null ? Icon(Icons.camera_alt, size: 30.sp, color: Colors.white) : null,
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: _nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Full Name', labelStyle: TextStyle(color: Colors.white70)),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white70)),
            ),
            SizedBox(height: 20.h),
            _isLoading
                ? CircularProgressIndicator()
                : Custombutton(title: 'Update Profile', ontap: _updateProfile)
            // _isLoading
            //     ? CircularProgressIndicator()
            //     : ElevatedButton(
            //         onPressed: _updateProfile,
            //         style: ElevatedButton.styleFrom(backgroundColor: Color(0xff4023D7)),
            //         child: Text('Update Profile', style: TextStyle(color: Colors.white)),
            //       ),
          ],
        ),
      ),
    );
  }
}
