
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';

class RfLoadingPage extends StatelessWidget {

  RfLoadingPage({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpinKitCircle(
          color: color ??AppColors.primaryColor,
          size: 72.0.w,
        ),
        SizedBox(height: 20.h,),
        RFText(text: "Please Wait")

      ],
    );
  }
}
