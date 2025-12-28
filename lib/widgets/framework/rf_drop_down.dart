
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';




class RFDropDown extends StatelessWidget {

  final String name;
  var selectedValue;
  final List<OptionModel> totalOptionList;
  final Function(OptionModel selectedObject, Map<String, dynamic> jsonMapResult)? onChange;
  Widget? icon;
  String? dataType;
  String? hintText;
  Color? textColor;
  double? textSize;
  BoxDecoration? decoration;
  bool? readOnly;
  Map<String, dynamic>? jsonMap;

  RFDropDown({
    super.key,
    required this.name,
    required this.selectedValue,
    required this.totalOptionList,
    required this.onChange,
    this.icon,
    this.dataType,
    this.hintText,
    this.textColor,
    this.textSize,
    this.decoration,
    this.readOnly,
    this.jsonMap,
  });

  Map<String, dynamic>? _addValueToModel(OptionModel item, String type){
    jsonMap![item.fieldName.toString()] = type == 'int' ? int.parse(item.optionValue.toString()) : item.optionValue.toString();
    return jsonMap;
  }

  @override
  Widget build(BuildContext context) {
    List<OptionModel> expectedOptionList = totalOptionList.where((item) => item.fieldName==name).toList();
    bool sortingPossible = true;
    for(OptionModel item in expectedOptionList){
      if(item.optionOrder == null){
        sortingPossible = false;
        break;
      }
    }
    if(sortingPossible){
      //sort from low to high according to order
      expectedOptionList.sort((a, b) => a.optionOrder!.compareTo(b.optionOrder!));
      //sort from high to low according to order
      //expectedOptionList.sort((a, b) => b.optionOrder!.compareTo(a.optionOrder!));
    }
    String type = dataType ?? 'int';
    String? selection;
    bool onlyRead = readOnly ?? false;
    if (selectedValue != null) {
      if (selectedValue.toString().isNotEmpty) {
        List<OptionModel> validList = totalOptionList.where((item) => item.fieldName==name && item.optionValue.toString()==selectedValue.toString()).toList();
        if(validList.isNotEmpty){
          selection = selectedValue.toString();
        }
      }
    }
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: decoration ?? BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              icon: icon ?? const Icon(Icons.keyboard_arrow_down),
              hint: Text(hintText ??'Choose', style: TextStyle(fontSize: textSize ?? 14.sp, color: textColor ?? Colors.black87)),
              onChanged: onlyRead ? null : (selectedValue) {
                OptionModel selectedObject = expectedOptionList.where((item) => item.optionValue.toString()==selectedValue).toList()[0];
                onChange!(selectedObject, _addValueToModel(selectedObject, type)!);
              },
              value: selection,
              items: expectedOptionList.map((OptionModel value) {
                return DropdownMenuItem<String>(
                  value: value.optionValue.toString(),
                  child: Text(value.optionText!, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: textSize ?? 14.sp, color: textColor ?? Colors.black87)),
                );
              }).toList()),
        ),
      ),
    );
  }
}
