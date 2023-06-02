class ApiEndPoints {
  static final String baseUrl = "https://bifatlaundrybe.online";
  static _AuthEndPoint authEngponts = _AuthEndPoint();
}

class _AuthEndPoint {
  final String savingFCMToken = "/api/v1/notification/fcmToken";
}
