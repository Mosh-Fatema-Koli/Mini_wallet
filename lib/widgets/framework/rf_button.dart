
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';


class RFButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? buttonTextSize;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? buttonRadius;
  final Alignment? buttonAlignment;
  final EdgeInsets? buttonPadding;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Function onPressed;

  const RFButton({
    super.key,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.borderColor,
    this.borderWidth,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonRadius,
    this.buttonAlignment,
    this.buttonPadding,
    this.icon,
    this.iconColor,
    this.iconSize,
    required this.onPressed,
    this.buttonTextSize,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Align(
      alignment: buttonAlignment ?? Alignment.center,
      child: MaterialButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius ?? 12).r,
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.5.w,
          ),
        ),
        minWidth: buttonWidth ?? width.w,
        height: buttonHeight ?? 48.h,
        onPressed: () {
          onPressed();
        },
        color: buttonColor ?? AppColors.primaryColor,
        child: Padding(
          padding: buttonPadding ?? const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8).w,
          child: Row(
            mainAxisSize: MainAxisSize.min, // Adjust size to fit content
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(fontSize: buttonTextSize ?? 12.sp, color: textColor ?? Colors.white,),),
              if (icon != null) SizedBox(width: 8.w), // Space between icon and text
              if (icon != null)Icon(icon, color: iconColor ?? textColor ?? Colors.white, size: iconSize ?? 24.h,),
            ],
          ),
        ),
      ),
    );
  }
}
