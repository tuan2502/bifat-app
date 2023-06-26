class DistrictModel {
  String? name;
  String? code;
  List<dynamic>? wards;

  DistrictModel({this.name, this.code, this.wards});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      name: json['name'],
      code: json['code'],
      wards: json['wards'] != null
          ? List<dynamic>.from(json['wards'])
          : null,
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
