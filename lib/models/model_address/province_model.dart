class ProvinceModel {
  final String? name;
  final String? code;
  List<dynamic>? districts;

  ProvinceModel({this.name, this.code, this.districts});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
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
