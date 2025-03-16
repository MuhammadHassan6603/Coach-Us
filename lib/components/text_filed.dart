import 'package:didpool/components/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled(
      {super.key,
      required this.hintext,
      this.filledcolor = AppColor.blackcolor,
      this.perfixicon,
      this.obscure=false,
      this.suffexicon,
      this.enabled = true,
    this.onTap,
    this.controller,
      });
  final String hintext;
  final filledcolor;
  final Widget? perfixicon;
  final bool obscure;
  final Widget? suffexicon;
  final bool enabled;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: obscure,
        onTap: enabled ? null : onTap, 
        readOnly: !enabled,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintext,
          fillColor: filledcolor,
          prefixIcon: perfixicon,
          suffixIcon: suffexicon,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.black),
          ),
          disabledBorder: OutlineInputBorder( 
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
