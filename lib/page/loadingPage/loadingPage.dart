// import 'package:flutter/material.dart';

// class LoadingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         // Nội dung của trang chính
//         YourMainContentWidget(),

//         // Layer cho trang loading
//         Opacity(
//           opacity: 0.7, // Điều chỉnh độ mờ của layer loading
//           child: ModalBarrier(
//             dismissible: false,
//             color: Colors.grey, // Màu nền của layer loading
//           ),
//         ),
//         Center(
//           child: CircularProgressIndicator(), // Widget hiển thị loading indicator
//         ),
//       ],
//     );
//   }
// }
