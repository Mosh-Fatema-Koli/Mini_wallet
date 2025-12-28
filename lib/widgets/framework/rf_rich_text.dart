
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFRichText extends StatelessWidget {

  final String text;
  final TextOverflow? overflow;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final bool? isMandatory;

  const RFRichText({
    super.key,
    required this.text,
    this.overflow,
    this.size,
    this.color,
    this.weight,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(
        text: text,
          style: TextStyle(fontSize: size ?? 14.sp, color: color ?? Colors.black87, fontWeight: weight ?? FontWeight.normal),
          children: isMandatory!
              ? [
                WidgetSpan(child: SizedBox(width: 4.w)),
                  TextSpan(
                    text: "*",
                    style: TextStyle(fontSize: size ?? 14.sp, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ]
              : []),
    );
  }
}
