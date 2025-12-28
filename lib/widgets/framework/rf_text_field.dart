
import 'package:boilerplate_of_cubit/widgets/framework/rf_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFTextField extends StatelessWidget {

  final String? name;
  var textValue;
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final dynamic keyboard;
  final int? maximumLine;
  final dynamic readOnly;
  final Function(String textValue, Map<String, dynamic>? jsonMapResult)? onChange;
  final Function(String textValue, Map<String, dynamic>? jsonMapResult)? onComplete;
  String? dataType;
  Color? textColor;
  Color? hintTextColor;
  double? textSize;
  BoxDecoration? decoration;
  TextInputAction? inputAction;
  Map<String, dynamic>? jsonMap;

  RFTextField({
    super.key,
    this.name,
    this.textValue,
    this.textColor,
    required this.controller,
    this.onChange,
    this.hintText,
    this.hintTextColor,
    this.textSize,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboard,
    this.decoration,
    this.maximumLine,
    this.readOnly,
    this.dataType,
    this.inputAction,
    this.onComplete,
    this.jsonMap,
  });

  Map<String, dynamic>? _addValueToModel(String value, String name, String type){
    if(name.isNotEmpty){
      jsonMap?[name] = type == 'int' ? int.parse(value.toString()) : value.toString();
    }
    return jsonMap;
  }

  @override
  Widget build(BuildContext context) {
    var width  = MediaQuery.of(context).size.width;
    String type = dataType ?? 'text';
    String fieldName = name ?? '';
    String defaultText = '';
    if (textValue != null) {
      defaultText = textValue.toString();
    }
    controller.text = defaultText;
    return Container(
      width: width.w,
      decoration: decoration ?? BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(
                0, 0), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              name !=null? SizedBox(height: 10.h,):SizedBox(),
              name !=null? RFText(text: name,size: 12.sp,):SizedBox(),
              TextFormField(
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                keyboardType: keyboard ?? TextInputType.text,
                textInputAction: inputAction ?? TextInputAction.go,
                maxLines: maximumLine ?? 1,
                style: TextStyle(fontSize: textSize ?? 14.sp, color: textColor ?? Colors.black87,),
                readOnly: readOnly ?? false,
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if(onComplete!= null){
                    onComplete!(controller.text.toString(), _addValueToModel(controller.text.toString(), fieldName, type));
                  }
                },
                onChanged: (value) {
                  if(onChange != null){
                    onChange!(value.toString(), _addValueToModel(value.toString(), fieldName, type));
                  }
                },
                decoration: InputDecoration(
                  hintText: hintText ?? '',
                  hintStyle: TextStyle(fontSize: textSize ?? 14.sp, color: hintTextColor ?? Colors.grey.withOpacity(.8)),
                  border: InputBorder.none,
                  suffixIcon: suffixIcon,
                  contentPadding: EdgeInsets.only(bottom: 16.h, top: 16.h, right: 12.w),
                  prefixIconConstraints: prefixIcon != null ? BoxConstraints(minWidth: 24.w, maxHeight: 24.h) : BoxConstraints(),
                  prefixIcon: prefixIcon != null ? Padding(
                    padding: EdgeInsets.only(left: 0.w, right: 4.w),
                    child: prefixIcon,
                  ) : const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
