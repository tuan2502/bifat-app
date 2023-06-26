import 'dart:convert';

import 'package:bifat_app/models/model_address/district_model.dart';
import 'package:bifat_app/models/model_address/province_model.dart';
import 'package:bifat_app/models/model_address/ward_model.dart';
import 'package:bifat_app/services/user_api.dart';
import 'package:bifat_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShippingDialog extends StatefulWidget {
  const ShippingDialog({Key? key}) : super(key: key);

  @override
  _ShippingDialogState createState() => _ShippingDialogState();
}

class _ShippingDialogState extends State<ShippingDialog> {
  String? selectedDistrict;
  String? selectedWard;
  String? address;
  List<ProvinceModel> provinceModel = [];
  List<DistrictModel> provinceModelByCode = [];
  List<DistrictModel> districtModel = [];
  List<WardModel> districtModelByCode = [];
  List<WardModel> wardModel = [];

 
  Future<void> fetchProvinceByCode() async {
    final response = await UserApi.fetchProvinceByCode();
    setState(() {
      provinceModelByCode = response;
    });
  }

  Future<void> fetchDistrictsByCode(String code) async {
    final response = await UserApi.fetchDistrictsByCode(code);
    setState(() {
      districtModelByCode = response;
    });
  }

  Future<void> fetchProvince() async {
    final response = await UserApi.fetchProvinces();
    setState(() {
      provinceModel = response;
    });
  }

  Future<void> fetchDistricts() async {
    final response = await UserApi.fetchDistricts();
    setState(() {
      districtModel = response;
    });
  }

  Future<void> fetchWards() async {
    final response = await UserApi.fetchWards();
    setState(() {
      wardModel = response;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Giao nhận hàng'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: provinceModelByCode.isNotEmpty
                ? selectedDistrict = '${provinceModelByCode[0].code}'
                : null,
            dropdownColor: wPurBlue,
            itemHeight: 50,
            decoration: const InputDecoration(
              labelText: 'Quận / Huyện',
              labelStyle:
                  TextStyle(color: wWhite, fontWeight: FontWeight.bold),
              fillColor: wPurBlue,
              filled: true,
            ),
            style: const TextStyle(color: wWhite, fontSize: 16),
            items: provinceModelByCode.map((var value) {
              return DropdownMenuItem<String>(
                value: value.code,
                child: Text(
                    '${utf8.decode(value!.name.toString().runes.toList())}'),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedDistrict = newValue ?? '';
                print('wards: $selectedDistrict');
                fetchDistrictsByCode(selectedDistrict.toString()).then((data) {
                  setState(() {
                    districtModelByCode;
                    print('wards: ${districtModelByCode}');
                    selectedWard = districtModelByCode.isNotEmpty
                        ? '${districtModelByCode[0].code}'
                        : '';
                  });
                });
              });
            },
          ),
          Text('wards: ${districtModelByCode}'),
          DropdownButtonFormField<String>(
            value: selectedWard,
            dropdownColor: wPurBlue,
            itemHeight: 50,
            decoration: const InputDecoration(
              labelText: 'Phường / Xã',
              labelStyle:
                  TextStyle(color: wWhite, fontWeight: FontWeight.bold),
              fillColor: wPurBlue,
              filled: true,
            ),
            style: const TextStyle(color: wWhite, fontSize: 16),
            items: districtModelByCode.map((var value) {
              return DropdownMenuItem<String>(
                value: value.code,
                child: Text(
                    '${utf8.decode(value!.name.toString().runes.toList())}'),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedWard = newValue ?? '';
                print('ward: $selectedWard' );
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Số nhà / đường',
            ),
            onChanged: (value) {
              address = value;
              // Handle address input
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Đồng ý',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          onPressed: () {
            // Handle shipping information submission
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
