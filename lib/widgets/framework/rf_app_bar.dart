//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class RFAppBar extends AppBar {
//
//   final String? titleText;
//   final double? titleSize;
//   final FontWeight? titleWeight;
//   final Color? titleColor;
//   final IconData? icon;
//   final BoxDecoration? iconDecoration;
//   final Color? iconBackgroundColor;
//   final Color? iconBorderColor;
//   final double? iconBorderWidth;
//   final Color? iconColor;
//   final bool? centerTitle;
//   final double? toolbarHeight;
//   final Color? backgroundColor;
//   final Color? shadowColor;
//   final double? elevation;
//   final RoundedRectangleBorder? roundedBorderRadius;
//   final Function() onPressed;
//
//   RFAppBar({
//     super.key,
//     this.titleText,
//     this.titleSize,
//     this.titleWeight,
//     this.titleColor,
//     this.icon,
//     this.iconDecoration,
//     this.iconBackgroundColor,
//     this.iconBorderColor,
//     this.iconBorderWidth,
//     this.iconColor,
//     this.centerTitle,
//     this.toolbarHeight,
//     this.backgroundColor,
//     this.shadowColor,
//     this.elevation,
//     this.roundedBorderRadius,
//     required this.onPressed,
//   }){
//     AppBar(
//       leading: Padding(
//         padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
//         child: GestureDetector(
//             onTap: () {
//               onPressed();
//             },
//             child: Container(
//               decoration: iconDecoration ?? BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: iconBackgroundColor ?? Colors.white,
//                   borderRadius: BorderRadius.circular(12.r),
//                   border: Border.fromBorderSide(BorderSide(color: iconBorderColor ?? Colors.grey.withOpacity(0.3), width: iconBorderWidth ?? 1.w)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: iconBorderColor != null ? iconBorderColor!.withOpacity(0.15) : Colors.grey.withOpacity(0.15),
//                       spreadRadius: 1.r,
//                       blurRadius: 2.r,
//                       offset: const Offset(1, 1), // changes position of shadow
//                     ),
//                   ]
//               ),
//               child: Icon(
//                 icon ?? Icons.arrow_back_outlined,
//                 size: 24.h,
//                 color: iconColor ?? Colors.black87.withOpacity(0.8),
//               ),
//             )),
//       ),
//       title: Text(
//         titleText ?? '',
//         style: TextStyle(
//             color: titleColor ?? Colors.black87.withOpacity(0.8),
//             fontSize: titleSize ?? 22.sp,
//             fontWeight: titleWeight ?? FontWeight.bold),
//       ),
//       backgroundColor: backgroundColor ?? Colors.white,
//       foregroundColor:  backgroundColor ?? Colors.white,
//       surfaceTintColor: backgroundColor ?? Colors.white,
//       shadowColor: shadowColor ?? Colors.grey.withOpacity(0.05),
//       centerTitle: centerTitle ?? true,
//       toolbarHeight: toolbarHeight ?? 64.h,
//       leadingWidth: 60.w,
//       elevation: elevation ?? 1,
//       shape: roundedBorderRadius ?? RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16).r, bottomRight: Radius.circular(16).r)),
//     );
//   }
//
//   AppBar build() {
//     return AppBar(
//       leading: Padding(
//         padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 12.h),
//         child: GestureDetector(
//             onTap: () {
//               onPressed();
//             },
//             child: Container(
//               decoration: iconDecoration ?? BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: iconBackgroundColor ?? Colors.white,
//                   borderRadius: BorderRadius.circular(12.r),
//                   border: Border.fromBorderSide(BorderSide(color: iconBorderColor ?? Colors.grey.withOpacity(0.3), width: iconBorderWidth ?? 1.w)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: iconBorderColor != null ? iconBorderColor!.withOpacity(0.15) : Colors.grey.withOpacity(0.15),
//                       spreadRadius: 1.r,
//                       blurRadius: 2.r,
//                       offset: const Offset(1, 1), // changes position of shadow
//                     ),
//                   ]
//               ),
//               child: Icon(
//                 icon ?? Icons.arrow_back_outlined,
//                 size: 24.h,
//                 color: iconColor ?? Colors.black87,
//               ),
//             )),
//       ),
//       title: Text(
//         titleText ?? '',
//         style: TextStyle(
//             color: titleColor ?? Colors.black87,
//             fontSize: titleSize ?? 22.sp,
//             fontWeight: titleWeight ?? FontWeight.bold),
//       ),
//       backgroundColor: backgroundColor ?? Colors.white,
//       foregroundColor:  backgroundColor ?? Colors.white,
//       surfaceTintColor: backgroundColor ?? Colors.white,
//       shadowColor: shadowColor ?? Colors.grey.withOpacity(0.3),
//       centerTitle: centerTitle ?? true,
//       toolbarHeight: toolbarHeight ?? 64.h,
//       leadingWidth: 60.w,
//       elevation: elevation ?? 8,
//       shape: roundedBorderRadius ?? RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16).r, bottomRight: Radius.circular(16).r)),
//     );
//   }
//
// }
