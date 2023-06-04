import 'package:flutter/material.dart';

class ServicesModel with ChangeNotifier{
  String? id;
  String? name;
  int? price;
  int? quantity;
  String? decoration;
  String? image_url;
  
  ServicesModel(
      {this.id,
      this.name,
      this.price,
      this.quantity,
      this.decoration,
      this.image_url});
  
  ServicesModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    price = json["price"];
    quantity = json["quantity"];
    decoration = json["decoration"];
    image_url = json["image_url"];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["price"] = price;
    _data["quantity"] = quantity;
    _data["decoration"] = decoration;
    _data["image_url"] = image_url;
    return _data;
  }

  static List<ServicesModel> serviceFromSnapshot (List serviceSnapshot) {
    return serviceSnapshot.map((data) {
      return ServicesModel.fromJson(data);
    }).toList();
  }
}