import 'dart:convert';

import 'package:bifat_app/models/fragrant_model.dart';
import 'package:bifat_app/models/item_type_model.dart';
import 'package:bifat_app/models/material_model.dart';
import 'package:bifat_app/models/model_address/district_model.dart';
import 'package:bifat_app/models/model_address/province_model.dart';
import 'package:bifat_app/models/model_address/ward_model.dart';
import 'package:bifat_app/models/order_bill_model.dart';
import 'package:bifat_app/models/order_model.dart';
import 'package:bifat_app/models/user_service_model.dart';
import 'package:bifat_app/services/service_api.dart';
import 'package:bifat_app/services/user_api.dart';
import 'package:bifat_app/services/user_service_api.dart';
import 'package:bifat_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../models/model_service/service_detail_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  UserServiceModel? userServiceModel;
  List<FragrantModel> fragrantModel = [];
  List<ItemTypeModel> itemTypeModel = [];
  List<MaterialModel> materialModel = [];
  List<ProvinceModel> provinceModel = [];
  List<DistrictModel> provinceModelByCode = [];
  List<DistrictModel> districtModel = [];
  List<WardModel> districtModelByCode = [];
  List<WardModel> wardModel = [];


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController kilogramController = TextEditingController();
  final TextEditingController chatLieuVaiController = TextEditingController();
  final TextEditingController loaiDoController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String selectedMuiHuong = '';
  String selectedLoaiDo = '';
  String selectedChatLieu = '';
  String selectedProvince = '';
  String selectedDistrict = '';
  String selectedWard = '';
  String? nameDistrict ='';
  String? nameWard ='';
  bool isShippingSelected = false;
  bool isFastLaundrySelected = false;
  String address = '';
  int paymentValue = 0;
  String selectShip = '';
  String addressDetail = '';
  // String selectedPay= '';

  int selectedPay = 0;
  List<DateTime>? dateList = [];
  OrderModel? orderModel;
  OrderBillModel? dataBill;
  double? totalPrice = 0.0;
  double? wallet;

  @override
  void initState() {
    super.initState();
    checkUserService();
    fetchFragrants();
    fetchItemTypes();
    fetchMaterials();
    fetchProvinceByCode();
    getWallet();
  }

  @override
  void dispose() {
    kilogramController.dispose();
    chatLieuVaiController.dispose();
    loaiDoController.dispose();
    diaChiController.dispose();
    super.dispose();
  }

  void toggleShipping(bool? value) {
    setState(() {
      isShippingSelected = value ?? false;
    });
  }



  ShowDataTime() async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        if (dateTime == DateTime(2023, 6, 15)) {
          return false;
        } else {
          return true;
        }
      },
    );
    // print(dateTimeList);
    setState(() {
      dateList = dateTimeList;
    });
  }

  Widget selectedPayment() {
    final ServiceDetailModel serviceDetail =
        ModalRoute.of(context)?.settings.arguments as ServiceDetailModel;
    return Column(
        children: serviceDetail.price != 0
            ? <Widget>[
                RadioListTile<int>(
                  value: 0,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: (value) {
                    setState(() {
                      selectedPay = value!;
                    });
                  },
                  title: const Text(
                    'Thanh toán bằng tiền mặt',
                    style: TextStyle(color: wWhite),
                  ),
                ),
                RadioListTile<int>(
                  value: 1,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: (value) {
                    setState(() {
                      selectedPay = value!;
                    });
                  },
                  title: const Text(
                    'Thanh toán qua VNPay',
                    style: TextStyle(color: wWhite),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                RadioListTile<int>(
                  value: 2,
                  enableFeedback: serviceDetail.price! > wallet!,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: serviceDetail.price! <= wallet!
                      ? (value) {
                          setState(() {
                            selectedPay = value!;
                          });
                        }
                      : null,
                  title: const Text(
                    'Thanh toán qua ví BIFAT',
                    style: TextStyle(color: wWhite),
                  ),
                  subtitle: serviceDetail.price != null &&
                          serviceDetail.price! > wallet!
                      ? const Text('Số tiền trong ví không đủ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 235, 188, 185)))
                      : null,
                ),
                RadioListTile<int>(
                  value: 3,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: (value) {
                    setState(() {
                      selectedPay = value!;
                    });
                  },
                  title: const Text(
                    'Thanh toán qua Banking',
                    style: TextStyle(color: wWhite),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ]
            : <Widget>[
                RadioListTile<int>(
                  value: 0,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: (value) {
                    setState(() {
                      selectedPay = value!;
                    });
                  },
                  title: const Text(
                    'Thanh toán bằng tiền mặt',
                    style: TextStyle(color: wWhite),
                  ),
                ),
                RadioListTile<int>(
                  value: 1,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: (value) {
                    setState(() {
                      selectedPay = value!;
                    });
                  },
                  title: const Text(
                    'Thanh toán qua VNPay',
                    style: TextStyle(color: wWhite),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                RadioListTile<int>(
                  value: 2,
                  enableFeedback: serviceDetail.price! > wallet!,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: serviceDetail.price! <= wallet!
                      ? (value) {
                          setState(() {
                            selectedPay = value!;
                          });
                        }
                      : null,
                  title: const Text(
                    'Thanh toán qua ví BIFAT',
                    style: TextStyle(color: wWhite),
                  ),
                  subtitle: serviceDetail.price != null &&
                          serviceDetail.price! > wallet!
                      ? const Text('Số tiền trong ví không đủ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 235, 188, 185)))
                      : null,
                ),
                RadioListTile<int>(
                  value: 3,
                  groupValue: selectedPay,
                  activeColor: wWhite,
                  onChanged: (value) {
                    setState(() {
                      selectedPay = value!;
                    });
                  },
                  title: const Text(
                    'Thanh toán qua Banking',
                    style: TextStyle(color: wWhite),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ]);
  }

  Future<void> _pickDistrict(newValue) async {
    setState(() {
      selectedDistrict = newValue ?? '';
      fetchDistrictsByCode(selectedDistrict);
      provinceModelByCode.forEach((e){
        if(e.code == selectedDistrict){
          nameDistrict = utf8.decode(e.name.toString().runes.toList());
          print('district from Order: ${nameDistrict}');
        }
      });
    });
  }

  Future<void> _pickWard(newValue) async {
    setState(() {
      selectedWard = newValue ?? '';
      districtModelByCode.forEach((e) {
        if (e.code == selectedWard) {
          nameWard = utf8.decode(e.name.toString().runes.toList());
          print('ward from Order: ${nameWard}');
        }
      });
    });
  }

  Widget formNormalService() {
    List<DateTime>? date = dateList;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        color: wPurBlue,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  // NumberTextInputFormatter(),
                ],
                controller: kilogramController,
                decoration: const InputDecoration(
                  labelText: 'Cân nặng đồ ( ~kg )',
                  labelStyle: TextStyle(
                      color: wWhite, fontSize: 16, fontWeight: FontWeight.bold),
                  hintStyle: TextStyle(color: wWhite, fontSize: 16),
                  filled: true,
                ),
                cursorColor: wWhite,
                style: const TextStyle(color: wWhite, fontSize: 16),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập giá trị';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" không phải là số hợp lệ';
                  }
                  if (n < 0 || n > 100) {
                    return 'Giá trị phải nằm trong khoảng từ 0 đến 100';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: fragrantModel.isNotEmpty
                    ? selectedLoaiDo = '${itemTypeModel[0].id}'
                    : null,
                dropdownColor: wPurBlue,
                itemHeight: 50,
                decoration: const InputDecoration(
                  labelText: 'Loại đồ',
                  labelStyle:
                      TextStyle(color: wWhite, fontWeight: FontWeight.bold),
                  fillColor: wPurBlue,
                  filled: true,
                ),
                style: const TextStyle(color: wWhite, fontSize: 16),
                items: itemTypeModel.map((var value) {
                  return DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(
                        '${utf8.decode(value!.name.toString().runes.toList())}'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLoaiDo = newValue ?? '';
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: fragrantModel.isNotEmpty
                    ? selectedChatLieu = '${materialModel[0].id}'
                    : null,
                dropdownColor: wPurBlue,
                itemHeight: 50,
                decoration: const InputDecoration(
                  labelText: 'Chất Liệu',
                  labelStyle:
                      TextStyle(color: wWhite, fontWeight: FontWeight.bold),
                  fillColor: wPurBlue,
                  filled: true,
                ),
                style: const TextStyle(color: wWhite, fontSize: 16),
                items: materialModel.map((var value) {
                  return DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(
                        '${utf8.decode(value!.name.toString().runes.toList())}'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedChatLieu = newValue ?? '';
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: fragrantModel.isNotEmpty
                    ? selectedMuiHuong = '${fragrantModel[0].id}'
                    : null,
                dropdownColor: wPurBlue,
                itemHeight: 50,
                decoration: const InputDecoration(
                  labelText: 'Mùi hương',
                  labelStyle:
                      TextStyle(color: wWhite, fontWeight: FontWeight.bold),
                  fillColor: wPurBlue,
                  filled: true,
                ),
                style: const TextStyle(color: wWhite, fontSize: 16),
                items: fragrantModel.map((var value) {
                  return DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(
                        '${utf8.decode(value!.name.toString().runes.toList())}'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMuiHuong = newValue ?? '';
                  });
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      ShowDataTime();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: wPurBlue),
                    child: date == null || date.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 8.0),
                              Text('Chọn ngày'),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(width: 8.0),
                                    Text('Ngày đặt: '),
                                    Text(date[0].toString().substring(0, 16)),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        16.0), // Thêm khoảng cách giữa hai cột
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(width: 8.0),
                                    Text('Ngày nhận: '),
                                    Text(date[1].toString().substring(0, 16)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  )
                ],
              ),
              Wrap(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isShippingSelected,
                        onChanged: toggleShipping,
                        activeColor: wWhite,
                        shape: CircleBorder(),
                        side: BorderSide(color: wWhite, width: 2),
                      ),
                      const Text(
                        'Giao hàng',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: wWhite),
                      ),
                    ],
                  ),
                  if (isShippingSelected)
                    Column(
                      children: <Widget>[
                        DropdownButtonFormField<String>(
                          value: provinceModelByCode.isNotEmpty
                              ? selectedDistrict =
                                  '${provinceModelByCode[0].code}'
                              : null,
                          dropdownColor: wPurBlue,
                          itemHeight: 50,
                          decoration: const InputDecoration(
                            labelText: 'Quận / Huyện',
                            labelStyle: TextStyle(
                                color: wWhite, fontWeight: FontWeight.bold),
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
                          onChanged: _pickDistrict,
                        ),
                        DropdownButtonFormField<String>(
                          value: districtModelByCode.isNotEmpty
                              ? selectedWard = '${districtModelByCode[0].code}'
                              : null,
                          dropdownColor: wPurBlue,
                          itemHeight: 50,
                          decoration: const InputDecoration(
                            labelText: 'Phường / Xã',
                            labelStyle: TextStyle(
                                color: wWhite, fontWeight: FontWeight.bold),
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
                          onChanged: _pickWard,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Số nhà / đường',
                            labelStyle: TextStyle(
                                color: wWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            hintStyle: TextStyle(color: wWhite, fontSize: 16),
                            filled: true,
                          ),
                          cursorColor: wWhite,
                          style: const TextStyle(color: wWhite, fontSize: 16),
                          onChanged: (value) {
                            address = value;
                          },
                        ),
                      ],
                    )
          
                ],
              ),
              Column(
                children: [selectedPayment()],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formComboService() {
    List<DateTime>? date = dateList;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        color: wPurBlue,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  // NumberTextInputFormatter(),
                ],
                controller: kilogramController,
                decoration: const InputDecoration(
                  labelText: 'Cân nặng đồ ( Tối đa: 6kg )',
                  labelStyle: TextStyle(
                      color: wWhite, fontSize: 16, fontWeight: FontWeight.bold),
                  hintStyle: TextStyle(color: wWhite, fontSize: 16),
                  filled: true,
                ),
                cursorColor: wWhite,
                style: const TextStyle(color: wWhite, fontSize: 16),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập giá trị';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" không phải là số hợp lệ';
                  }
                  if (n < 0 || n > 100) {
                    return 'Giá trị phải nằm trong khoảng từ 0 đến 100';
                  }
                  return null;
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      ShowDataTime();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: wPurBlue),
                    child: date == null || date.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 8.0),
                              Text('Chọn ngày'),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(width: 8.0),
                                    Text('Ngày đặt: '),
                                    Text(date[0].toString().substring(0, 16)),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        16.0), // Thêm khoảng cách giữa hai cột
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(width: 8.0),
                                    Text('Ngày nhận: '),
                                    Text(date[1].toString().substring(0, 16)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  )
                ],
              ),
              Wrap(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isShippingSelected,
                        onChanged: toggleShipping,
                        activeColor: wWhite,
                        shape: CircleBorder(),
                        side: BorderSide(color: wWhite, width: 2),
                      ),
                      const Text(
                        'Giao hàng',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: wWhite),
                      ),
                    ],
                  ),
                  if (isShippingSelected)
                    if (isShippingSelected)
                      Column(
                        children: <Widget>[
                          DropdownButtonFormField<String>(
                            value: provinceModelByCode.isNotEmpty
                                ? selectedDistrict =
                                    '${provinceModelByCode[0].code}'
                                : null,
                            dropdownColor: wPurBlue,
                            itemHeight: 50,
                            decoration: const InputDecoration(
                              labelText: 'Quận / Huyện',
                              labelStyle: TextStyle(
                                  color: wWhite, fontWeight: FontWeight.bold),
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
                            onChanged: _pickDistrict,
                          ),
                          DropdownButtonFormField<String>(
                            value: districtModelByCode.isNotEmpty
                                ? selectedWard =
                                    '${districtModelByCode[0].code}'
                                : null,
                            dropdownColor: wPurBlue,
                            itemHeight: 50,
                            decoration: const InputDecoration(
                              labelText: 'Phường / Xã',
                              labelStyle: TextStyle(
                                  color: wWhite, fontWeight: FontWeight.bold),
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
                            onChanged: _pickWard,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Số nhà / đường',
                              labelStyle: TextStyle(
                                  color: wWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              hintStyle: TextStyle(color: wWhite, fontSize: 16),
                              filled: true,
                            ),
                            cursorColor: wWhite,
                            style: const TextStyle(color: wWhite, fontSize: 16),
                            onChanged: (value) {
                              address = value;
                            },
                          ),
                        ],
                      )
                ],
              ),
              Column(
                children: [selectedPayment()],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //lấy dữ liệu dịch vụ từ trang LaundryServicePage
    final ServiceDetailModel serviceDetail =
        ModalRoute.of(context)?.settings.arguments as ServiceDetailModel;

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      if (isKeyboardVisible) {
        SystemChannels.textInput.invokeMethod('TextInput.setLocale', 'vi');
      }
      return userServiceModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            :Scaffold(
          appBar: AppBar(
            title: Text('Đặt hàng'),
            backgroundColor: wPurBlue,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: serviceDetail.price == 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      formNormalService(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 360,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  addressDetail = '';
                                  addressDetail = '$address, $nameWard, $nameDistrict, Thành phố Hồ Chí Minh';
                                  //gửi dữ liệu dịch từ trang này qua OrderPage
                                  orderModel = OrderModel(
                                    userServiceId: userServiceModel!.id,
                                    fragrantId: selectedMuiHuong,
                                    itemTypeId: selectedLoaiDo,
                                    materialId: selectedChatLieu,
                                    userVoucherId: '',
                                    description: '',
                                    address: isShippingSelected ? addressDetail : '',
                                    receiveDate: dateList![0].toString(),
                                    deliveryDate: dateList![1].toString(),
                                    totalPrice: totalPrice,
                                    totalQuantity:
                                        double.parse(kilogramController.text),
                                    isShipping: isShippingSelected
                                        ? 'SHIPPED'
                                        : 'NOSHIPPED',
                                  );
                                  dataBill = await UserServiceApi.orderService(orderModel!);

                                  Navigator.pushNamed(
                                    context,
                                    "billPage",
                                    arguments: {
                                      'serviceDetail': serviceDetail,
                                      'orderModel': orderModel,
                                      'payment': selectedPay,
                                      'dataBill': dataBill,
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: wPurBlue,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.payment,
                                      color: wWhite,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Thanh toán',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      formComboService(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 360,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  addressDetail = '';
                                  addressDetail = '$address, $nameWard, $nameDistrict, Thành phố Hồ Chí Minh';
                                  print('address: $addressDetail');
                                  orderModel = OrderModel(
                                    userServiceId: userServiceModel!.id,
                                    fragrantId: selectedMuiHuong,
                                    itemTypeId: selectedLoaiDo,
                                    materialId: selectedChatLieu,
                                    userVoucherId: '',
                                    description: '',
                                    address: isShippingSelected ? addressDetail : '',
                                    receiveDate: dateList![0].toString(),
                                    deliveryDate: dateList![1].toString(),
                                    totalPrice: totalPrice! +
                                        serviceDetail.price!.toDouble(),
                                    totalQuantity: 6,
                                    isShipping: isShippingSelected
                                        ? 'SHIPPED'
                                        : 'NOSHIPPED',
                                  );

                                  dataBill = await UserServiceApi.orderService(orderModel!);

                                  Navigator.pushNamed(
                                    context,
                                    "billPage",
                                    arguments: {
                                      'serviceDetail': serviceDetail,
                                      'orderModel': orderModel,
                                      'dataBill': dataBill,
                                      'payment': selectedPay,
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: wPurBlue,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.payment,
                                      color: wWhite,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Thanh toán',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ));
    });
  }


//get API
  Future<void> checkUserService() async {
    final response = await UserServiceApi.checkUserService();
    setState(() {
      userServiceModel = response;
    });
  }

  Future<void> fetchFragrants() async {
    final response = await ServiceApi.fetchFragrants();
    setState(() {
      fragrantModel = response;
    });
  }

  Future<void> fetchItemTypes() async {
    final response = await ServiceApi.fetchItemTypes();
    setState(() {
      itemTypeModel = response;
    });
  }

  Future<void> fetchMaterials() async {
    final response = await ServiceApi.fetchMaterials();
    setState(() {
      materialModel = response;
    });
  }

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

  Future<void> getWallet() async {
    final response = await UserApi.fetchUser();
    setState(() {
      wallet = response.balance;
      print(wallet);
    });
  }

}
