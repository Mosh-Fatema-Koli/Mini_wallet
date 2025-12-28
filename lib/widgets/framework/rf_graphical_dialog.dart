
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';
import 'package:lottie/lottie.dart';

class RFGraphicalDialog extends StatelessWidget {

  final String? imagePath;
  final String? title;
  final String? subTitle;
  final String? okText;
  final String? cancelText;
  final Color? titleColor;
  final Color? subTitleColor;
  final Function? okPressed;
  final Function? cancelPressed;

  const RFGraphicalDialog({
    super.key,
    this.imagePath,
    this.title,
    this.subTitle,
    this.okText,
    this.cancelText,
    this.titleColor,
    this.subTitleColor,
    this.okPressed,
    this.cancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12).r),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 8).w,
          child: Column(
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
                      imagePath!.contains('.json')
                          ? Lottie.asset(imagePath!,height: 112.h, fit: BoxFit.cover, alignment: Alignment.center)
                          : Image.asset(imagePath!, fit: BoxFit.fitHeight, height: 64.h, alignment: Alignment.center,),
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
                      SizedBox(height: 8.h),
                      Text(subTitle!, textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: subTitleColor ?? Colors.black87.withOpacity(0.8)),),
                      SizedBox(height: 32.h),
                    ],
                  )
                  : const SizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  okText != null && okText!.isNotEmpty
                      ? RFButton(
                          buttonRadius: 12.r,
                          text: okText!,
                          textColor: Colors.white,
                          buttonColor: AppColors.primaryColor,
                          buttonHeight: 48.h,
                          buttonTextSize: 16.sp,
                          buttonWidth: 112.w,
                          buttonPadding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4).w,
                          onPressed: okPressed!,
                        )
                      : const SizedBox(),
                  cancelText != null && cancelText!.isNotEmpty
                      ? Row(
                          children: [
                            SizedBox(width: 16.w),
                            RFButton(
                              buttonRadius: 12.r,
                              text: cancelText!,
                              buttonColor: AppColors.save_black,
                              buttonHeight: 48.h,
                              buttonTextSize: 16.sp,
                              buttonWidth: 112.w,
                              buttonPadding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4).w,
                              onPressed: cancelPressed!,
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}
