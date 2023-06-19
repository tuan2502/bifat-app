class DistrictModel {
  String? name;
  String? code;
  List<dynamic>? districts;

  DistrictModel({this.name, this.code, this.districts});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      name: json['name'],
      code: json['code'],
      districts: json['districts'] != null
          ? List<dynamic>.from(json['districts'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['code'] = code;
    if (districts != null) {
      data['districts'] = districts;
    }
    return data;
  }
}
