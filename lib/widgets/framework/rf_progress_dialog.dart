

import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';


class RFProgressDialog extends StatelessWidget {

  final String? title;
  final String? subTitle;
  final Color? progressColor;

  const RFProgressDialog({
    super.key,
    this.title,
    this.subTitle,
    this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          SpinKitCircle(
            color: progressColor ?? AppColors.primaryColor,
            size: 64.0.w,
          ),
          SizedBox(height: 16.h),
          Text(title??'Please Wait...', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black87.withOpacity(0.8)),),
          SizedBox(height: 8.h),
          subTitle != null ? Text(subTitle!, textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.black87.withOpacity(0.8)),) : const SizedBox(),
          SizedBox(height: 16.h),
        ],
      ),
      contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 8).w,
    );
  }
}
