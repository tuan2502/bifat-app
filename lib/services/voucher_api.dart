import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;

import '../models/model_voucher/voucher_detail_model.dart';
import '../models/model_voucher/voucher_model.dart';

class VoucherApi {
  static Future<List<VouchersModel>> fetchVouchers() async {
    var token = await FirebaseServices.getAccessToken();
    const url = '$BASE_URL/vouchers?page=1&size=10&sort=name%3Aasc';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 201) {
      final body = res.body;
      final json = jsonDecode(body);
      // print('json: $json');
      final data = json['data'] as List<dynamic>;
      final vouchers = data.map((e) {
        return VouchersModel.fromJson(e);
      }).toList();
      // print('vouchers: $vouchers');
      return vouchers;
    } else {
      throw Exception('Failed to fetch vouchers');
    }
  }

  static Future<List<VoucherDetailModel>> fetchVoucherById() async {
    var token = await FirebaseVouchers.getAccessToken();
    var voucherId = await FirebaseVouchers.getVoucherId();
    var url = '$BASE_URL/vouchers/voucherId/$voucherId';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      final data = json['data'];

      final voucher = VoucherDetailModel.fromJson(data);

      return [voucher];
    } else {
      throw Exception('Failed to fetch voucher');
    }
  }
}
