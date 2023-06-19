import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../services/user_api.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Container(
            //     width: 35,
            //     height: 35,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       color: Colors.yellowAccent,
            //     ),
            //     child: const Icon(IconlyLight.edit),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 10),
        for (var user in users)
          Column(
            children: [
              Text(
                user.fullname,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Future<void> fetchUser() async {
    final response = await UserApi.fetchUser();
    setState(() {
      users = response;
    });
  }
}



//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 115,
//       width: 115,
//       child: Stack(
//         fit: StackFit.expand,
//         clipBehavior: Clip.none,
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(
//               FirebaseAuth.instance.currentUser!.photoURL!,
//             ),
//           ),
//           Positioned(
//             right: -16,
//             bottom: 0,
//             child: SizedBox(
//               height: 46,
//               width: 46,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                     side: const BorderSide(color: Colors.white),
//                   ),
//                   backgroundColor: const Color(0xFFF5F6F9),
//                 ),
//                 onPressed: () {},
//                 child: const Icon(
//                   Icons.camera_alt,
//                   color: wBlack,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -60,
//             child: Container(
//               width: 350,
//               color: wMain,
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   //mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${FirebaseAuth.instance.currentUser!.displayName}',
//                       style: const TextStyle(
//                         fontSize: 21,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '${FirebaseAuth.instance.currentUser!.email}',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
