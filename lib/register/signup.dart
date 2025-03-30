import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:didpool/components/text_filed.dart';
import 'package:didpool/register/complete_profile.dart';
import 'package:didpool/register/login.dart';
import 'package:didpool/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;
  bool isObscure = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await _firebaseService.signUpWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text,
          fullName: fullname.text.trim(),
          phoneNumber: phone.text.trim(),
        );

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompleteProfile()),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: AppText(
                      'Hey There!',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  AppText(
                    'Create an Account',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFiled(
                    hintext: 'Full Name',
                    perfixicon: Icon(Icons.person),
                    controller: fullname,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Full name is required';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 15.h),
                  CustomTextFiled(
                    hintext: 'Phone Number',
                    perfixicon: Icon(Icons.phone),
                    controller: phone,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Phone number is required';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 15.h),
                  CustomTextFiled(
                    hintext: 'Email',
                    perfixicon: Icon(Icons.email),
                    controller: email,
                    // validator: _validateEmail,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextFiled(
                    hintext: 'Password',
                    obscure: isObscure,
                    controller: password,
                    // validator: _validatePassword,
                    perfixicon: Icon(Icons.lock),
                    suffexicon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  isLoading
                      ? CircularProgressIndicator(
                          color: Colors.purple,
                        )
                      : Custombutton(
                          title: 'Register',
                          ontap: _registerUser,
                        ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                            color: Colors.grey, indent: 20, endIndent: 10),
                      ),
                      Text(
                        "or",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                            color: Colors.grey, indent: 10, endIndent: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Image.asset(
                          "assets/google.png",
                          scale: 3.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}