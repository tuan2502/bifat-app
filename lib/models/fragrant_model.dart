import 'package:flutter/material.dart';

class FragrantModel with ChangeNotifier {
  String? id;
  String? name;
  int? quantity;
  String? status;

  FragrantModel(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.status});

  FragrantModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    quantity = json["quantity"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["quantity"] = quantity;
    _data["status"] = status;
    return _data;
  }

}
