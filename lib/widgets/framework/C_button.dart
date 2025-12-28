
import 'package:boilerplate_of_cubit/widgets/framework/rf_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boilerplate_of_cubit/library.dart';



class CButton extends StatelessWidget {

  const CButton({super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30).r,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                ],
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 14).w,
            child: Center(child: RFText(text: buttonText, size: 15.sp, weight: FontWeight.bold, color: Colors.white)),
          )),
    );
  }
}
