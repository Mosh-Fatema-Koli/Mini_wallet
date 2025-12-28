


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFBoxDecoration extends BoxDecoration {

  final BoxShape? boxShape;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? shadowColor;

  RFBoxDecoration({
    this.boxShape,
    this.color,
    this.borderRadius,
    this.border,
    this.shadowColor
  });

  BoxDecoration build(){
    return BoxDecoration(
        shape: boxShape ?? BoxShape.rectangle,
        color: color ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        border: border ?? Border.all(color: Colors.grey.withOpacity(0.4), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ]
    );
  }
}