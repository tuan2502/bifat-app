import 'package:bifat_app/services/voucher_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/voucher_model.dart';

import 'Discount.dart';
import 'DiscoutPageDemo.dart';

class DiscountWidget extends StatefulWidget {
  const DiscountWidget({super.key});
  @override
  State<DiscountWidget> createState() => _DiscountWidgetState();
}

class _DiscountWidgetState extends State<DiscountWidget> {
  List<VouchersModel> vouchers = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    fetchVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.72,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (var voucher in vouchers)
          InkWell(
            onTap: () {
              saveVoucherIdToLocalStorage(voucherId: voucher.id.toString());

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiscountPageDetail(
                    code: 'ABC123',
                    price: 10.99,
                    description: 'Discount Description',
                    startDate: DateTime(2023, 1, 1),
                    endDate: DateTime(2023, 1, 31),
                    postDate: DateTime.now(),
                    name: 'Discount Name',
                    quantity: 100,
                    imageUrl: '',
                  ),
                ),
              );
            },
            child: Discount(
              imgPath: voucher.imageUrl.toString(),
              nameService: voucher.name.toString(),
              descriptionService: 'alo alo',
            ),
          ),
      ],
    );
  }

  Future<void> fetchVouchers() async {
    final respone = await VoucherApi.fetchVouchers();
    setState(() {
      vouchers = respone;
    });
  }

  saveVoucherIdToLocalStorage({required String voucherId}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('voucherId', voucherId);
    return true;
  }

  // Future<void> placeOrderVoucher() async {
  //   var token = await FirebaseServices.getAccessToken();
  //   var voucherId = await FirebaseServices.getVoucherId();

  //   final url =
  //       '$BASE_URL/vouchers/voucherId/321d5a42-2168-4d19-827b-100152da0783';
  // }
}
