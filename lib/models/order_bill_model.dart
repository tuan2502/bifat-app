import 'package:flutter/material.dart';

class OrderBillModel with ChangeNotifier {
  String? orderId;
  String? serviceId;
  double? totalPrice;
  String? orderStatus;

  OrderBillModel(
      {required this.orderId,
      required this.serviceId,
      required this.totalPrice,
      required this.orderStatus});

  OrderBillModel.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    serviceId = json["serviceId"];
    totalPrice = json["totalPrice"];
    orderStatus = json["orderStatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["serviceId"] = serviceId;
    _data["totalPrice"] = totalPrice;
    _data["orderStatus"] = orderStatus;
    return _data;
  }

}
