
import 'dart:convert';

List<OptionModel> optionModelFromJson(String str) => List<OptionModel>.from(json.decode(str).map((x) => OptionModel.fromJson(x)));

String optionModelToJson(List<OptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OptionModel {
  int? modelDefaultId;
  int? parentId;
  String? modelInfoName;
  String? fieldName;
  String? optionText;
  int? optionValue;
  int? optionOrder;

  OptionModel({
    this.modelDefaultId,
    this.parentId,
    this.modelInfoName,
    this.fieldName,
    this.optionText,
    this.optionValue,
    this.optionOrder,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
    modelDefaultId: json["ModelDefaultId"],
    parentId: json["ParentId"],
    modelInfoName: json["ModelInfoName"],
    fieldName: json["FieldName"],
    optionText: json["OptionText"],
    optionValue: json["OptionValue"],
    optionOrder: json["OptionOrder"],
  );

  Map<String, dynamic> toJson() => {
    "ModelDefaultId": modelDefaultId,
    "ParentId": parentId,
    "ModelInfoName": modelInfoName,
    "FieldName": fieldName,
    "OptionText": optionText,
    "OptionValue": optionValue,
    "OptionOrder": optionOrder,
  };
}
