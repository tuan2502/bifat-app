import 'package:bifat_app/models/model_address/province_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

import '../../../models/user_model.dart';
import '../../../services/user_api.dart';
import '../../../styles/color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  List<UserModel> users = [];
  List<ProvinceModel> provinces = [];
  late String selectedWard;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchProvince(); // Gọi hàm fetchProvince()
    selectedWard = ''; // Gán giá trị mặc định cho selectedWard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sửa thông tin',
          style: TextStyle(color: wWhite),
        ),
        backgroundColor: wPurBlue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
                  for (var user in users)
                    SizedBox(
                      width: 105,
                      height: 105,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          user.avatarUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.yellowAccent,
                      ),
                      child: const Icon(IconlyLight.camera),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    for (var user in users)
                      TextFormField(
                        initialValue: user.fullname,
                        decoration: InputDecoration(
                          fillColor: wPurBlue,
                          labelText: 'Tên đầy đủ',
                          prefixIcon: const Icon(IconlyLight.profile),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.redAccent),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            user.fullname = value;
                          });
                        },
                      ),
                    const SizedBox(height: 10),
                    for (var user in users)
                      TextFormField(
                        initialValue: DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(user.birthday.toString())),
                        decoration: InputDecoration(
                          labelText: 'Ngày sinh',
                          prefixIcon: const Icon(Icons.date_range_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.redAccent),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    const SizedBox(height: 10),
                    for (var user in users)
                      TextFormField(
                        //initialValue: user.email,
                        decoration: InputDecoration(
                          labelText: 'Số nhà',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    //for (var province in provinces)
                    DropdownButtonFormField<String>(
                      value: selectedWard,
                      decoration: InputDecoration(
                        labelText: 'Tỉnh',
                        labelStyle: const TextStyle(color: wBlack),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 147, 152, 160)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 147, 152, 160)),
                        ),
                      ),
                      items: provinces.map((province) {
                        final districtName = province.name ?? '';
                        return DropdownMenuItem<String>(
                          value: districtName,
                          child: Text(districtName),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWard = newValue ?? '';
                        });
                      },
                    ),

                    const SizedBox(height: 10),
                    // for (var user in users)
                    //   DropdownButtonFormField<String>(
                    //     value: selectedWard,
                    //     decoration: InputDecoration(
                    //       labelText: 'Quận/Huyện',
                    //       labelStyle: const TextStyle(color: wBlack),
                    //       filled: true,
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //             color: Color.fromARGB(255, 147, 152, 160)),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //             color: Color.fromARGB(255, 147, 152, 160)),
                    //       ),
                    //       //dropdownColor: Colors.white,
                    //     ),
                    //     items: <String>['Downy', 'Comfort', 'Omo']
                    //         .map((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         selectedWard = newValue ?? '';
                    //       });
                    //     },
                    //   ),
                    // const SizedBox(height: 10),
                    // for (var user in users)
                    //   DropdownButtonFormField<String>(
                    //     value: selectedWard,
                    //     decoration: InputDecoration(
                    //       labelText: 'Phường/Xã',
                    //       labelStyle: const TextStyle(color: wBlack),
                    //       filled: true,
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //             color: Color.fromARGB(255, 147, 152, 160)),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: const BorderSide(
                    //             color: Color.fromARGB(255, 147, 152, 160)),
                    //       ),
                    //       //dropdownColor: Colors.white,
                    //     ),
                    //     items: <String>['Downy', 'Comfort', 'Omo']
                    //         .map((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         selectedWard = newValue ?? '';
                    //       });
                    //     },
                    //   ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () {}, //updateUserProfile,
                    child: const Text('Cập nhật'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchUser() async {
    final response = await UserApi.fetchUser();
    setState(() {
      users = [response];
    });
  }

  Future<void> fetchProvince() async {
    final response = await UserApi.fetchProvinces();
    setState(() {
      provinces = response;
    });
  }
}

//   Future<void> updateUserProfile() async {
//     if (users.isNotEmpty) {
//       final user = users[0];
//       final update = UpdateProfile(
//         fullname: user.fullname,
//         birthday: user.birthday,
//         addressNum: user.phoneNum,
//         province: user.,
//         address: user.address,
//         // Provide other necessary properties
//       );
//       await UserApi.updateUserProfile(update);
//     }
//   }
// }

  // void updateUser() async {
  //   if (users.isNotEmpty) {
  //     final user = updates[0]; // Get the first user from the `users` list

  //     final update = UpdateProfile(
  //       fullname: user.fullname,
  //       birthday: user.birthday,
  //       addressNum: user.addressNum,
  //       province: user.province,
  //       district: user.district,
  //       ward: user.ward,
  //     );

  //     await UserApi.updateUserProfile(
  //       update.fullname,
  //       update.birthday,
  //       update.addressNum,
  //       update.district,
  //       update.province,
  //       update.ward,
  //     );

  //     setState(() {
  //       updates[0] = update;
  //     });
  //   }
  // }


  // Future<void> updatePut() async {
  //   final update = UpdateProfile(
  //     fullname: 'Tran Thanh Hiepn111 12', // Thay bằng fullname mới
  //     birthday: '2001-08-12T17:00:00Z', // Thay bằng birthday mới
  //     addressNum: '76b 61',
  //     province: 'Tinh Ba Ria-Vung Tau',
  //     district: 'Thanh Pho Vung Tau',
  //     ward: 'Phuong Thang Nhat',
  //   );

  //   await UserApi.updateUserProfile(update);
  //   setState(() {
  //     users[0].fullname =
  //         update.fullname; // Cập nhật fullname trong danh sách users
  //     // users[0].address =
  //     //     update.address; // Cập nhật address trong danh sách users
  //   });
  // }

  // Future<void> updateUser() async {
  //   final updatedUser = UserModel(
  //     id: users[0].id,
  //     fullname: users[0].fullname, // Replace with the updated fullname
  //     email: users[0].email,
  //     emailVerified: users[0].emailVerified,
  //     status: users[0].status,
  //     address: users[0].address, // Replace with the updated address
  //     birthday: users[0].birthday, // Replace with the updated birthday
  //     createOn: users[0].createOn,
  //     avatarUrl: users[0].avatarUrl,
  //     phoneNum: users[0].phoneNum, // Replace with the updated phone number
  //     provider: users[0].provider,
  //     balance: users[0].balance,
  //     role: users[0].role,
  //   );

  //   await UserApi.updateUserProfile(updatedUser);
  //   setState(() {
  //     users[0] = updatedUser;
  //   });
  // }
//}
