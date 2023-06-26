import 'package:flutter/material.dart';

class WardModel with ChangeNotifier {
  String? name;
  String? code;

  WardModel({this.name, this.code});

  WardModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["code"] = code;
    return _data;
  }
}
