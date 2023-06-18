import 'package:flutter/material.dart';

class ItemTypeModel with ChangeNotifier {
  String? id;
  String? name;
  String? status;

  ItemTypeModel(
      {required this.id,
      required this.name,
      required this.status});

  ItemTypeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["status"] = status;
    return _data;
  }

}
