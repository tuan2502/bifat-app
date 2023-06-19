class WardModel {
  String? name;
  String? code;
  List<dynamic>? wards;

  WardModel({this.name, this.code, this.wards});

  factory WardModel.fromJson(Map<String, dynamic> json) {
    return WardModel(
      name: json['name'],
      code: json['code'],
      wards: json['wards'] != null ? List<dynamic>.from(json['wards']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['code'] = code;
    if (wards != null) {
      data['wards'] = wards;
    }
    return data;
  }
}
