
import 'package:boilerplate_of_cubit/widgets/framework/rf_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFWarningDialog extends StatelessWidget {

  final String? imagePath;
  final String? title;
  final String? subTitle;
  final String? okText;
  final String? cancelText;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? okButtonTextColor;
  final Color? okButtonColor;
  final Color? okButtonBorderColor;
  final Function? okPressed;
  final Function? cancelPressed;

  const RFWarningDialog({
    super.key,
    this.imagePath,
    this.title,
    this.subTitle,
    this.okText,
    this.cancelText,
    this.titleColor,
    this.subTitleColor,
    this.okButtonTextColor,
    this.okButtonColor,
    this.okButtonBorderColor,
    this.okPressed,
    this.cancelPressed
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12).r),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h),
          imagePath != null && imagePath!.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Image.asset(imagePath!, fit: BoxFit.fitHeight, height: 64.h, alignment: Alignment.center,),
              SizedBox(height: 24.h),
            ],
          )
              : const SizedBox(),
          title != null && title!.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title!, textAlign: TextAlign.center, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: titleColor?? Colors.black87.withOpacity(0.8)),),
              SizedBox(height: 8.h),
            ],
          )
              : const SizedBox(),
          subTitle != null && subTitle!.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(subTitle!, textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: subTitleColor ?? Colors.black87.withOpacity(0.8)),),
              SizedBox(height: 16.h),
            ],
          )
              : const SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cancelText != null && cancelText!.isNotEmpty
                  ? Row(
                children: [
                  RFButton(
                    buttonRadius: 8.r,
                    text: cancelText!,
                    textColor: Colors.black87.withOpacity(0.8),
                    buttonColor: Colors.white,
                    borderWidth: 1.5.w,
                    borderColor: Colors.grey.withOpacity(0.5),
                    buttonHeight: 38.h,
                    buttonTextSize: 14.sp,
                    buttonWidth: 112.w,
                    buttonPadding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4).w,
                    onPressed: cancelPressed!,
                  ),
                ],
              )
                  : const SizedBox(),
              SizedBox(width: 16.w),
              okText != null && okText!.isNotEmpty
                  ? RFButton(
                buttonRadius: 8.r,
                text: okText!,
                textColor: okButtonTextColor ?? Colors.black87.withOpacity(0.8),
                buttonColor: okButtonColor ?? Colors.white,
                borderWidth: 1.5.w,
                borderColor: okButtonBorderColor ?? Colors.red.withOpacity(0.5),
                buttonHeight: 38.h,
                buttonTextSize: 14.sp,
                buttonWidth: 112.w,
                buttonPadding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4).w,
                onPressed: okPressed!,
              )
                  : const SizedBox(),
            ],
          ),
          SizedBox(height: 12.h),
        ],
      ),
      contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 8).w,
    );
  }
}
