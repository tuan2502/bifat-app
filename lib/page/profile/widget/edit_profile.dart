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

  @override
  void initState() {
    super.initState();
    fetchUser();
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
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    for (var user in users)
                      TextFormField(
                        initialValue:
                            user.fullname, // Giá trị ban đầu của trường tên
                        decoration: InputDecoration(
                          fillColor: wPurBlue,
                          labelText: 'Tên đầy đủ',
                          prefixIcon: const Icon(IconlyLight.profile),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent)),
                        ),
                        onChanged: (value) {
                          // Hàm callback khi người dùng thay đổi giá trị trường tên
                          setState(() {
                            user.fullname = value;
                          });
                        },
                      ),
                    const SizedBox(height: 10),
                    for (var user in users)
                      TextFormField(
                        initialValue:
                            user.email, // Giá trị ban đầu của trường email
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent)),
                        ),
                        onChanged: (value) {
                          // Hàm callback khi người dùng thay đổi giá trị trường email
                          setState(() {
                            if (users.isNotEmpty) {
                              users[0].email = value;
                            }
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
                                  const BorderSide(color: Colors.redAccent)),
                        ),
                        onChanged: (value) {
                          // Hàm callback khi người dùng thay đổi giá trị trường ngày sinh
                          setState(() {
                            if (users.isNotEmpty) {
                              users[0].birthday = value;
                            }
                          });
                        },
                      ),
                    const SizedBox(height: 10),
                    for (var user in users)
                      TextFormField(
                        initialValue: user
                            .phoneNum, // Giá trị ban đầu của trường số điện thoại
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent)),
                        ),
                        onChanged: (value) {
                          // Hàm callback khi người dùng thay đổi giá trị trường số điện thoại
                          setState(() {
                            if (users.isNotEmpty) {
                              users[0].phoneNum = value;
                            }
                          });
                        },
                      ),
                    const SizedBox(height: 10),
                    for (var user in users)
                      TextFormField(
                        initialValue:
                            user.address, // Giá trị ban đầu của trường địa chỉ
                        decoration: InputDecoration(
                          labelText: 'Địa chỉ',
                          prefixIcon: const Icon(Icons.home),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.redAccent)),
                        ),
                        onChanged: (value) {
                          // Hàm callback khi người dùng thay đổi giá trị trường địa chỉ
                          setState(() {
                            if (users.isNotEmpty) {
                              users[0].address = value;
                            }
                          });
                        },
                      ),
                  ],
                ),
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
}
