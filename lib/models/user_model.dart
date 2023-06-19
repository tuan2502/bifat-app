class UserModel {
  final String id;
  late final String fullname;
  late final String email;
  final bool emailVerified;
  final String status;
  late final String? address;
  late final String? birthday;
  final String? createOn;
  final String? avatarUrl;
  late final String? phoneNum;
  final String? provider;
  final double? balance;
  final String? role;
  // final String? addressNum;
  // final String? province;
  // final String? district;
  // final String? ward;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.emailVerified,
    required this.status,
    required this.address,
    required this.birthday,
    this.createOn,
    required this.avatarUrl,
    required this.phoneNum,
    this.provider,
    this.balance,
    this.role,
    // this.addressNum,
    // this.district,
    // this.province,
    // this.ward,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final fullname = json['fullname'];
    final email = json['email'];
    final emailVerified = json['emailVerified'];
    final status = json['status'];
    final address = json['address'] ?? '';
    final birthday = json['birthday'] ?? '';
    final createOn = json['createOn'] ?? '';
    final avatarUrl = json['avatarUrl'] ?? '';
    final phoneNum = json['phoneNum'] ?? '';
    final provider = json['provider'] ?? '';
    final balance = json['balance'] ?? '';
    final role = json['role'] ?? '';
    // final addressNum = json['addressNum'] ?? '';
    // final district = json['district'] ?? '';
    // final provice = json['provice'] ?? '';
    // final ward = json['ward'] ?? '';
    return UserModel(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      status: json['status'],
      address: json['address'],
      birthday: json['birthday'],
      createOn: json['birthday'],
      avatarUrl: json['avatarUrl'],
      phoneNum: json['phoneNum'],
      provider: json['provider'],
      balance: json['balance'],
      role: json['role'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['fullname'] = this.fullname;
  //   data['email'] = this.email;
  //   data['emailVerified'] = this.emailVerified;
  //   data['status'] = this.status;
  //   data['address'] = this.address;
  //   data['birthday'] = this.birthday;
  //   data['createOn'] = this.createOn;
  //   data['avatarUrl'] = this.avatarUrl;
  //   data['phoneNum'] = this.phoneNum;
  //   data['provider'] = this.provider;
  //   data['balance'] = this.balance;
  //   data['role'] = this.role;
  //   return data;
  // }
}
