import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didpool/register/registration_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:didpool/components/text_filed.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String fullName = "User";

  @override
  void initState() {
    super.initState();
    getUserFullName();
  }

  void getUserFullName() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (uid.isNotEmpty) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        setState(() {
          fullName = userDoc['fullName'] ?? "User";
        });
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'gender': genderController.text,
        'dob': dobController.text,
        'weight': weightController.text,
        'height': heightController.text,
        'profileCompleted': true,
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationSuccess(fullname: fullName,)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating profile: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/with.png", scale: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: [
                    SizedBox(height: 23.h),
                    AppText(
                      'Let\'s complete your profile',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    SizedBox(height: 3.h),
                    AppText(
                      'It will help us know more about you!',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 17.h),
                    CustomTextFiled(
                      hintext: 'Choose gender',
                      perfixicon: Icon(Icons.people),
                      suffexicon: Icon(Icons.arrow_forward_ios_outlined),
                      enabled: false,
                      controller: genderController,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text("Male"),
                                    onTap: () {
                                      setState(() {
                                        genderController.text = 'Male';
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text("Female"),
                                    onTap: () {
                                      setState(() {
                                        genderController.text = 'Female';
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFiled(
                      hintext: 'Date of birth',
                      perfixicon: Icon(Icons.calendar_month),
                      controller: dobController,
                      enabled: false,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            dobController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Your weight',
                                prefixIcon: Icon(Icons.line_weight),
                                filled: true,
                                fillColor: Colors.black,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                              color: Color(0xff9d2999),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "KG",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Your Height',
                                prefixIcon: Image.asset(
                                  "assets/Swap.png",
                                  scale: 3.5,
                                ),
                                filled: true,
                                fillColor: Colors.black,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w),
                          Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                              color: Color(0xff9d2999),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "CM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Custombutton(
                      title: 'Next',
                      ontap: () {
                        if (genderController.text.isEmpty ||
                            dobController.text.isEmpty ||
                            weightController.text.isEmpty ||
                            heightController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please fill all fields")),
                          );
                        } else {
                          updateProfile();
                        }
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
