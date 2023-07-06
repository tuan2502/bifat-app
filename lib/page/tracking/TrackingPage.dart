import 'dart:convert';

import 'package:bifat_app/models/history_model.dart';
import 'package:bifat_app/services/user_service_api.dart';
import 'package:bifat_app/utils/FormatValue.dart';
import 'package:flutter/material.dart';

import '../../styles/color.dart';
import 'Tracking.dart';

class TrackingStep {
  final String title;
  final String description;

  TrackingStep({required this.title, required this.description});
}

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  HistoryModel? historyModel;
  List<Data>? dataHistory = [];

  void initState() {
    super.initState();
    fetchHistory();
  }
  

  @override
  Widget build(BuildContext context) {
    // print(dataHistory);
    return historyModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Lịch sử đơn hàng',
                style: TextStyle(
                    color: wWhite,
                    fontSize: 23,
                    fontWeight: FontWeight.bold // Thay đổi màu chữ của tiêu đề
                    ),
              ),
              iconTheme: const IconThemeData(
                  color: wWhite,
                  size: 30 // Thay đổi màu của biểu tượng nút Back
                  ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Navigate back to the previous screen
                  Navigator.pop(context);
                },
              ),
              backgroundColor: wPurBlue,
            ),
            body: ListView.builder(
              itemCount: dataHistory!.length,
              itemBuilder: (BuildContext context, int index) {
                Data history = dataHistory![index];
                return Container(
                  margin: EdgeInsets.only(bottom: 5,top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                        // Navigator.pushNamed(context, 'historyDetail',
                        //     arguments: history);
                      },
                    title: Text(
                      'Dịch vụ: ${history.type == 'ORDER_DEPOSIT' ? utf8.decode(history.services!.name.toString().runes.toList()) : 'Nạp tiền BIFAT'}',
                    ),
                    subtitle: Text(
                        'Thanh toán qua: ${history.paymentInfo!.provider}'),
                    trailing:
                        Text('${FormatValue.formatMoney(history.amount)}'),
                  ),
                );
              },
            ),
          );
  }

  Future<void> fetchHistory() async {
    final response = await UserServiceApi.fetchHistory();
    setState(() {
      historyModel = response;
      dataHistory = response.data;
    });
  }
}
