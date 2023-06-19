class UpdateProfile {
  final String? fullname;
  final String? birthday;
  final String? addressNum;
  final String? province;
  final String? district;
  final String? ward;

  UpdateProfile({
    required this.fullname,
    required this.birthday,
    required this.addressNum,
    required this.province,
    required this.district,
    required this.ward,
  });

//   String? get address => null;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) {
    return UpdateProfile(
      fullname: json['fullname'],
      birthday: json['birthday'],
      addressNum: json['addressnum'],
      district: json['district'],
      province: json['province'],
      ward: json['ward'],
    );
  }
}

  // factory UpdateProfile.fromJson(Map<String, dynamic> json) {
  //   final fullname = json['fullname'];
  //   final birthday = json['birthday'] ?? '';
  //   final addressNum = json['addressNum'] ?? '';
  //   final district = json['district'] ?? '';
  //   final province = json['province'] ?? '';
  //   final ward = json['ward'] ?? '';
  //   // final addressNum = json['addressNum'] ?? '';
  //   // final district = json['district'] ?? '';
  //   // final provice = json['provice'] ?? '';
  //   // final ward = json['ward'] ?? '';
  //   return UpdateProfile(
  //     fullname: json['fullname'],
  //     birthday: json['birthday'],
  //     addressNum: json['addressNum'],
  //     district: json['district'],
  //     province: json['province'],
  //     ward: json['ward'],
  //   );
  // }
  //}
