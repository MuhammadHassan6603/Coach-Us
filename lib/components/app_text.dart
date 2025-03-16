import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final double? height;
  final FontWeight fontWeight;
  final TextAlign align;
  final TextDecoration textDecoration;
  final TextOverflow overflow;
  final int? maxLines;
  final TextDirection? textDirection;
  final double? letterSpacing;
  const AppText(
    this.text, {
    super.key,
    this.color = Colors.black,
    required this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.align = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines,
    this.textDirection,
    this.height,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      style: GoogleFonts.poppins(
        letterSpacing: letterSpacing,
        height: height,
        color: textDecoration.contains(TextDecoration.underline)
            ? Colors.transparent
            : color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: Colors.black,
      ),
      textAlign: align,
    );
  }
}
