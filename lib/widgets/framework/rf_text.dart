import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFText extends StatelessWidget {

  final String? text;
  final Color? color;
  final double? size;
  final String? fontFamily;
  final int? maxLines;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? letterSpacing;
  final TextDirection? textDirection;
  final TextDecoration? decoration;
  TextOverflow? overflow;
  Paint? foreground;

  RFText({super.key,
    required this.text,
    this.color,
    this.size,
    this.fontFamily,
    this.maxLines,
    this.weight,
    this.textAlign,
    this.textDirection,
    this.wordSpacing,
    this.letterSpacing,
    this.decoration,
    this.overflow,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        decoration: decoration,
        fontFamily: fontFamily,
        fontSize: size ?? 12.sp,
        fontWeight: weight ?? FontWeight.w500,
        color: color ?? Colors.black87,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        foreground: foreground,
      ),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}