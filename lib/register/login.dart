import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:didpool/bottom_bar/bottom_bar.dart';
import 'package:didpool/components/app_text.dart';
import 'package:didpool/components/custom_button.dart';
import 'package:didpool/components/text_filed.dart';
import 'package:didpool/register/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser() async {
    if (isLoading == true) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomBarScreen()));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: AppText(
                    'Hey there',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                AppText(
                  'Welcome Back',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                SizedBox(height: 30.h),
                CustomTextFiled(
                  hintext: 'Email',
                  perfixicon: Icon(Icons.email),
                  controller: emailController,
                ),
                SizedBox(height: 15.h),
                CustomTextFiled(
                  hintext: 'Password',
                  obscure: isObscure,
                  perfixicon: Icon(Icons.lock),
                  controller: passwordController,
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
                SizedBox(height: 50.h),
                isLoading
                    ? CircularProgressIndicator(
                        color: Colors.purple,
                      )
                    : Custombutton(
                        title: 'Login',
                        ontap: loginUser,
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
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: 'Signup!',
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
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
    );
  }
}
