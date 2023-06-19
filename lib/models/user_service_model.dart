class UserServiceModel {
    String? id;
    String? idUser;
    String? idService;
    int? quantity;
    String? status;

  UserServiceModel({
    required this.id,
    required this.idUser,
    required this.idService,
    required this.quantity,
    required this.status,
  });

  UserServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    idService = json['idService'];
    quantity = json['quantity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["idUser"] = idUser;
    _data["idService"] = idService;
    _data["quantity"] = quantity;
    _data["status"] = status;
    return _data;
  }
}
