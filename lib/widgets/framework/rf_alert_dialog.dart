

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFAlertDialog extends StatelessWidget {

  final String title;
  final String subTitle;
  final String okText;
  final String? cancelText;
  final Function okPressed;
  final Function? cancelPressed;

  const RFAlertDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.okText,
    this.cancelText,
    required this.okPressed,
    this.cancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0).r),
      title: Text(title, style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.8)),),
      content: Text(subTitle, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black87.withOpacity(0.8)),),
      contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 8).w,
      actionsPadding: const EdgeInsets.only(top: 16, left: 24, right: 24).w,
      actions: [
        cancelText != null ? TextButton (
          onPressed: () {
            cancelPressed!();
          },
          child: Text(cancelText!),
        ) : const SizedBox(),
        TextButton (
          onPressed: () {
            okPressed();
          },
          child: Text(okText),
        ),
      ],
    );
  }
}
