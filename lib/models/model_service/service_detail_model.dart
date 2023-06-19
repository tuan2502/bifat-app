import 'package:flutter/material.dart';

class ServiceDetailModel with ChangeNotifier {
  final String? id;
  final String? name;
  final double? price;
  final int? quantity;
  final String? decoration;
  final String? image_url;

  ServiceDetailModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.decoration,
      required this.image_url});

  factory ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final name = json["name"];
    final price = json["price"];
    final quantity = json["quantity"];
    final decoration = json["decoration"];
    final imageUrl = json["image_url"];
    return ServiceDetailModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      decoration: json["decoration"],
      image_url: json["image_url"],
    );
  }
}
