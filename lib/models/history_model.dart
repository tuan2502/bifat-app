class HistoryModel {
  String? status;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  HistoryModel({this.status, this.message, this.pagination, this.data});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? totalPage;

  Pagination({this.page, this.limit, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class Data {
  String? id;
  double? amount;
  String? createDate;
  String? completeDate;
  String? type;
  PaymentInfo? paymentInfo;
  Services? services;
  bool? refund;

  Data(
      {this.id,
      this.amount,
      this.createDate,
      this.completeDate,
      this.type,
      this.paymentInfo,
      this.services,
      this.refund});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    createDate = json['createDate'];
    completeDate = json['completeDate'];
    type = json['type'];
    paymentInfo = json['paymentInfo'] != null
        ? new PaymentInfo.fromJson(json['paymentInfo'])
        : null;
    services = json['services'] != null
        ? new Services.fromJson(json['services'])
        : null;
    refund = json['refund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['createDate'] = this.createDate;
    data['completeDate'] = this.completeDate;
    data['type'] = this.type;
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.toJson();
    }
    data['refund'] = this.refund;
    return data;
  }
}

class PaymentInfo {
  String? id;
  String? provider;

  PaymentInfo({this.id, this.provider});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider'] = this.provider;
    return data;
  }
}

class Services {
  String? id;
  String? name;

  Services({this.id, this.name});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
