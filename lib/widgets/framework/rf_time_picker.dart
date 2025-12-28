
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';

class RFTimePicker extends StatelessWidget {

  final String? name;
  var timeValue;
  final String? hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String dateValue, Map<String, dynamic> jsonMapResult) onChange;
  Color? textColor;
  Color? hintTextColor;
  double? textSize;
  bool? readOnly;
  BoxDecoration? decoration;
  Map<String, dynamic>? jsonMap;
  final _miscController = MiscController();

  RFTimePicker({
    super.key,
    this.name,
    this.timeValue,
    this.hintText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChange,
    this.textColor,
    this.textSize,
    this.readOnly,
    this.decoration,
    this.jsonMap,
  });

  Map<String, dynamic>? _addValueToModel(String value, String name){
    if(jsonMap != null){
      jsonMap![name] = value.toString();
    }
    return jsonMap;
  }

  @override
  Widget build(BuildContext context) {
    String fieldName = name ?? '';
    bool disable = readOnly ?? false;
    controller.text = _miscController.getFormattedTimeFromString(timeString: timeValue) ?? '';
    return Container(
      width: double.infinity,
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
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          maxLines: 1,
          style: TextStyle(fontSize: textSize ?? 14.sp, color: textColor ?? Colors.black87),
          readOnly: true,
          onTap: () async {
            if(disable){
              null;
            } else {
              TimeOfDay? picked = await showTimePicker(
                initialEntryMode: TimePickerEntryMode.dial,
                context: context,
                initialTime: _miscController.timeOfDayFromString(timeString: timeValue) ?? TimeOfDay.now(),
                builder: (context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                    child: child!,
                  );
                },
              );
              if (picked != null && picked != _miscController.timeOfDayFromString(timeString: timeValue)) {
                String timeString = picked.format(context);
                controller.text = _miscController.getFormattedTimeFromString(timeString: timeString) ?? '';
                onChange(timeString, _addValueToModel(timeString, fieldName)!);
              }
            }
          },
          decoration: InputDecoration(
            hintText: hintText ?? 'Select Time',
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
      ),
    );
  }
}
