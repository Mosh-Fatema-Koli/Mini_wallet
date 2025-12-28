

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RFCheckBox extends StatelessWidget {

  final String name;
  var selectedValue;
  final Function(bool isChecked, Map<String, dynamic> jsonMapResult)? onChange;
  final String? dataType;
  final Color? activeColor;
  final String checkboxTitle;
  final Color? textColor;
  final double? textSize;
  bool? readOnly;
  final BoxDecoration? decoration;
  Map<String, dynamic>? jsonMap;

  RFCheckBox({
    super.key,
    required this.name,
    this.onChange,
    this.selectedValue,
    this.dataType,
    this.activeColor,
    required this.checkboxTitle,
    this.textColor,
    this.decoration,
    this.textSize,
    this.jsonMap
  });

  Map<String, dynamic>? _addValueToModel(String itemName, bool isChecked, String type){
    if(type == 'int'){
      jsonMap![itemName] = isChecked ? 1 : 0;
    } else {
      jsonMap![itemName] = isChecked ? '1' : '0';
    }
    return jsonMap;
  }

  @override
  Widget build(BuildContext context) {
    String type = dataType ?? 'int';
    String itemName = name;
    bool? selection;
    if (selectedValue != null) {
      if (selectedValue.toString().isNotEmpty) {
        selection = selectedValue.toString() == '1' ? true : false;
      }
    }
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
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Center(
          child: CheckboxListTile(
            value: selection ?? false,
            onChanged: (isChecked) {
              onChange!(isChecked!, _addValueToModel(itemName, isChecked, type)!);
            },
            title: Text(checkboxTitle, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: textSize ?? 14.sp, color: textColor ?? Colors.black87)),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            contentPadding: const EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}