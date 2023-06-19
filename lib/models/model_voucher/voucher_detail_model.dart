import 'package:flutter/material.dart';

class VoucherDetailModel with ChangeNotifier {
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

  VoucherDetailModel({
    this.id,
    this.code,
    this.price,
    this.description,
    this.startDate,
    this.endDate,
    this.postDate,
    this.name,
    this.quantity,
    this.status,
    this.imageUrl,
  });

  factory VoucherDetailModel.fromJson(Map<String, dynamic> json) {
    return VoucherDetailModel(
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
