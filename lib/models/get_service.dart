class getService {
  getService({
    required this.serviceId,
  });
  late final String serviceId;

  getService.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['serviceId'] = serviceId;
    return _data;
  }
}
