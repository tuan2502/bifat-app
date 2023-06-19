import 'dart:convert';
import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/fragrant_model.dart';
import 'package:bifat_app/models/order_model.dart';
import 'package:bifat_app/models/user_service_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class UserServiceApi {

  static Future userServiceApi(String serviceId) async {
    var token = await FirebaseServices.getAccessToken();
    // var serviceId = await FirebaseServices.getServiceId();
    var dataInput = jsonEncode(<String, dynamic>{
      'serviceId': serviceId,
    });
    final url = Uri.parse(
        '${BASE_URL}/user-service?serviceId=${serviceId}');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: dataInput,
    );
    if (response.statusCode == 200) {
      // print('success post: ${response.body}');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

//get serviceId checkUserService
  static Future<UserServiceModel> checkUserService() async {
    var token = await FirebaseServices.getAccessToken();
    var serviceId = 'b9abc377-406c-4827-8dad-a1b8de27861b';
    var url = '$BASE_URL/user-service/check-user-service?serviceId=${serviceId}';
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = response.body;
    final json = jsonDecode(body);
    final data = json['data'];
    final message = json['message'];
    if (response.statusCode == 200 && message.toString().contains('active')) {
      print('data: $data');
      return UserServiceModel.fromJson(data);
    } else if (response.statusCode == 404 && message.toString().contains('inactive')) {
      print('inactive');
      await userServiceApi(serviceId);
      return checkUserService();
    } else {
      throw Exception('Failed to get data');
    }
  }

  //order api
  static Future orderService(OrderModel orderModel) async {
    var token = await FirebaseServices.getAccessToken();

    var dataInput = jsonEncode(<String, dynamic>{
      'userServiceId': orderModel.userServiceId,
      'fragrantId': orderModel.fragrantId,
      "itemTypeId": orderModel.itemTypeId,
      "materialId": orderModel.materialId,
      'userVoucherId': orderModel.userVoucherId,
      'description': '',
      'address': orderModel.address,
      'receiveDate':  '${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(orderModel.receiveDate.toString()).toIso8601String()}Z',
      'deliveryDate':  '${DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(orderModel.deliveryDate.toString()).toIso8601String()}Z',
      'totalPrice': orderModel.totalPrice,
      'totalQuantity': orderModel.totalQuantity,
      'isShipping': orderModel.isShipping,
    });
    final url = Uri.parse(
        '${BASE_URL}/order');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: dataInput,
    );
    if (response.statusCode == 201) {
     var orderId = jsonDecode(response.body)['data']['orderId'];
      print('orderId: $orderId');
      return orderId;
    } else {
      print(response.statusCode);
      throw Exception('Failed to post data');
    }
  }

    static Future postCostFromWallet(String orderId) async {
    var token = await FirebaseServices.getAccessToken();
    var dataInput = jsonEncode(<String, dynamic>{
      'orderId': orderId,
    });
    final url = Uri.parse(
        '${BASE_URL}/transaction/paymentOrder/wallet?orderId=${orderId}');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: dataInput,
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']) ;

      return jsonDecode(response.body)['message'];
    } else {
      print('API post failed');
    }
  }

   static Future postCostFromVNPay(double totalPrice, String orderId) async {
    var token = await FirebaseServices.getAccessToken();
    String returnUrl = 'https://www.bifatlaundry.website/';

    var dataInput = jsonEncode(<String, dynamic>{
      "amount": totalPrice,
      "orderId": orderId,
      "returnUrl": returnUrl,
    });
    final url = Uri.parse(
        '${BASE_URL}/transaction/paymentOrder/vnPay');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: dataInput,
    );
    if (response.statusCode == 200) {
      var urlVnpay = jsonDecode(response.body)['data'];
      // print('urlVnpay1: $urlVnpay');
      return urlVnpay;
    } else {
      print('API post failed');
    }
  }



  //get fragrant data
  static Future<FragrantModel> getFragrant() async {
    var token = await FirebaseServices.getAccessToken();
    var serviceId = await FirebaseServices.getServiceId();
    var url = '$BASE_URL/service/serviceId/$serviceId';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'];

    if (res.statusCode != 200) {
      throw data["message"];
    }
    return FragrantModel.fromJson(data);
  }
}
