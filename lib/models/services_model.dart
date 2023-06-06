import 'package:flutter/material.dart';

class ServicesModel with ChangeNotifier{
  final String? id;
  final String? name;
  final double? price;
  final int? quantity;
  final String? decoration;
  final String? image_url;
  
  ServicesModel({
      required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.decoration,
      required this.image_url
  });
  
  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final name = json["name"];
    final price = json["price"];
    final quantity = json["quantity"];
    final decoration = json["decoration"];
    final image_url = json["image_url"];
    return ServicesModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      decoration: json["decoration"],
      image_url: json["image_url"],
    );
  }
  
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> _data = <String, dynamic>{};
  //   _data["id"] = id;
  //   _data["name"] = name;
  //   _data["price"] = price;
  //   _data["quantity"] = quantity;
  //   _data["decoration"] = decoration;
  //   _data["image_url"] = image_url;
  //   return _data;
  // }

  // static List<ServicesModel> serviceFromSnapshot (List serviceSnapshot) {
  //   return serviceSnapshot.map((data) {
  //     return ServicesModel.fromJson(data);
  //   }).toList();
  // }
}