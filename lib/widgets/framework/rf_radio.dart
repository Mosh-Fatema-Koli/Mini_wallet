
import 'package:flutter/material.dart';
import 'package:boilerplate_of_cubit/library.dart';


class RFRadio extends StatelessWidget {

  final String name;
  var selectedValue;
  final List<OptionModel> totalOptionList;
  final Function(OptionModel selectedObject, Map<String, dynamic>? jsonMapResult)? onChange;
  String? dataType;
  Color? activeColor;
  Color? textColor;
  double? textSize;
  bool? readOnly;
  Map<String, dynamic>? jsonMap;

  RFRadio({
    super.key,
    required this.name,
    required this.selectedValue,
    required this.totalOptionList,
    required this.onChange,
    this.dataType,
    this.activeColor,
    this.textColor,
    this.textSize,
    this.readOnly,
    this.jsonMap,
  });

  Map<String, dynamic>? _addValueToModel(OptionModel item, String type){
    Map<String, dynamic>? map;
    if(jsonMap != null){
      jsonMap![item.fieldName.toString()] = type == 'int' ? int.parse(item.optionValue.toString()) : item.optionValue.toString();
      map = jsonMap;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    bool onlyRead = readOnly ?? false;
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
    List<OptionModel> previousObject = [];
    if (selectedValue != null) {
      if (selectedValue.toString().isNotEmpty) {
        previousObject = expectedOptionList.where((item) => item.fieldName==name && item.optionValue.toString()==selectedValue.toString()).toList();
      }
    }
    String type = dataType ?? 'int';
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expectedOptionList.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return RadioListTile(
          value: expectedOptionList[index],
          groupValue: previousObject.isNotEmpty ? previousObject[0] : OptionModel(),
          visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
          title: Text(expectedOptionList[index].optionText!, style: TextStyle(color: textColor ?? Colors.black87, fontSize: textSize ?? 14.sp, fontWeight: FontWeight.normal),),
          onChanged: onlyRead ? null : (selectedObj) {
            OptionModel selectedObject = expectedOptionList[index];
            onChange!(selectedObject, _addValueToModel(selectedObject, type));
          },
          activeColor: activeColor ?? AppColors.primaryColor,
        );
      },
    );
  }

}