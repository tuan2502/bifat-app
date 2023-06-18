import 'package:flutter/material.dart';

class ServiceDetailModel with ChangeNotifier {
  String? id;
  String? name;
  double? price;
  int? quantity;
  String? description;
  String? image_url;

  ServiceDetailModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.description,
      required this.image_url});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    quantity = json["quantity"];
    description = json["description"];
    image_url = json["image_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["price"] = price;
    _data["quantity"] = quantity;
    _data["description"] = description;
    _data["image_url"] = image_url;
    return _data;
  }

}
