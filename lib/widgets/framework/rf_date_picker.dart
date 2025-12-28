
import 'package:boilerplate_of_cubit/library.dart';
import 'package:flutter/material.dart';



class RFDatePicker extends StatelessWidget {

  final String? name;
  var dateValue;
  final String? hintText;
  DateTime? minDate;
  DateTime? maxDate;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String dateValue, Map<String, dynamic>? jsonMapResult) onChange;
  Color? textColor;
  Color? hintTextColor;
  double? textSize;
  bool? readOnly;
  BoxDecoration? decoration;
  Map<String, dynamic>? jsonMap;
  final _miscController = MiscController();

  RFDatePicker({
    super.key,
    this.name,
    this.dateValue,
    this.hintText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChange,
    this.textColor,
    this.minDate,
    this.maxDate,
    this.textSize,
    this.readOnly,
    this.decoration,
    this.jsonMap,
  });

  Map<String, dynamic>? _addValueToModel(String value, String name){
    Map<String, dynamic>? map;
    if(jsonMap != null){
      jsonMap![name] = value.toString();
      map = jsonMap;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    String fieldName = name ?? '';
    bool disable = readOnly ?? false;
    controller.text = _miscController.formattedDateString(dateString: dateValue);
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
        padding: EdgeInsets.only(left: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            name !=null? SizedBox(height: 10.h,):SizedBox(),
            name !=null? RFText(text: name,size: 12.sp,):SizedBox(),

            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              maxLines: 1,
              style: TextStyle(fontSize: textSize ?? 14.sp, fontWeight: FontWeight.normal, color: textColor ?? Colors.black87),
              readOnly: true,
              onTap: () async {
                if(disable){
                  null;
                } else {
                  final DateTime? picked = await showDatePicker(

                      context: context,
                      initialDate: _miscController.dateTimeFromString(dateString: dateValue),
                      firstDate:minDate?? DateTime(1900),
                      lastDate:maxDate?? DateTime(2101));
                  if (picked != null && picked != _miscController.dateTimeFromString(dateString: dateValue)) {
                    String databaseDate = _miscController.stringFromDate(date: picked);
                    controller.text = _miscController.formattedDateString(dateString: databaseDate);
                    onChange(databaseDate, _addValueToModel(databaseDate, fieldName));
                  }
                }
              },
              decoration: InputDecoration(
                hintText: hintText ?? 'Select Date',
                hintStyle: TextStyle(fontSize: textSize ?? 14.sp, color: hintTextColor ?? Colors.black87.withOpacity(.5)),
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
    );
  }

}
