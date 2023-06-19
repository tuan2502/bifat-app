import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier{
  String? userServiceId;
  String? fragrantId;
  String? itemTypeId;
  String? materialId;
  String? userVoucherId;
  String? description;
  String? address;
  String? receiveDate;
  String? deliveryDate;
  double? totalPrice;
  double? totalQuantity;
  String? isShipping;

  OrderModel(
      {this.userServiceId,
      this.fragrantId,
      this.itemTypeId,
      this.materialId,
      this.userVoucherId,
      this.description,
      this.address,
      this.receiveDate,
      this.deliveryDate,
      this.totalPrice,
      this.totalQuantity,
      this.isShipping});

  OrderModel.fromJson(Map<String, dynamic> json) {
    userServiceId = json['userServiceId'];
    fragrantId = json['fragrantId'];
    itemTypeId = json['itemTypeId'];
    materialId = json['materialId'];
    userVoucherId = json['userVoucherId'];
    description = json['description'];
    address = json['address'];
    receiveDate = json['receiveDate'];
    deliveryDate = json['deliveryDate'];
    totalPrice = json['totalPrice'];
    totalQuantity = json['totalQuantity'];
    isShipping = json['isShipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userServiceId'] = userServiceId;
    data['fragrantId'] = fragrantId;
    data['itemTypeId'] = itemTypeId;
    data['materialId'] = materialId;
    data['userVoucherId'] = userVoucherId;
    data['description'] = description;
    data['address'] = address;
    data['receiveDate'] = receiveDate;
    data['deliveryDate'] = deliveryDate;
    data['totalPrice'] = totalPrice;
    data['totalQuantity'] = totalQuantity;
    data['isShipping'] = isShipping;
    return data;
  }
}
