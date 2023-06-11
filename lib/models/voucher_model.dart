import 'package:flutter/material.dart';

class VouchersModel with ChangeNotifier {
  final String? id;
  final String? code;
  final double? price;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? postDate;
  final String? name;
  final int? quantity;
  final String? status;
  final String? imageUrl;

  VouchersModel(
      {required this.id,
      required this.code,
      required this.price,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.postDate,
      required this.name,
      required this.quantity,
      required this.status,
      required this.imageUrl});

  factory VouchersModel.fromJson(Map<String, dynamic> json) {
    return VouchersModel(
      id: json['id'],
      code: json['code'],
      price: json['price'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      postDate: json['postDate'],
      name: json['name'],
      quantity: json['quantity'],
      status: json['status'],
      imageUrl: json['imageUrl'],
    );
  }
}
