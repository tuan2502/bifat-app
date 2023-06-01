import 'package:flutter/material.dart';

import '../components/Tips.dart';

class DiscoutWidget extends StatelessWidget {
  const DiscoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.72,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        InkWell(
          onTap: () {
            // Xử lý khi người dùng nhấp vào ServiceMore 1
            Navigator.pushNamed(context, 'itemPage');
          },
          child: const Tips(
            imgPath: 'assets/images/discount (1).png',
            nameService: 'BÙNG NỔ ƯU ĐÃI MỚI',
            descriptionService:
                'Giặt theo kí - sự lựa chọn của mọi nhà',
          ),
        ),
        InkWell(
          onTap: () {
            // Xử lý khi người dùng nhấp vào Tips 2
            Navigator.pushNamed(context, 'itemPage');
          },
          child: const Tips(
            imgPath: 'assets/images/discount (2).png',
            nameService: 'DÀNH RIÊNG CHO BẠN MỚI',
            descriptionService: 'Sự lựa chọn tiết kiệm cho gia đình',
          ),
        ),
        InkWell(
          onTap: () {
            // Xử lý khi người dùng nhấp vào Tips 3
            Navigator.pushNamed(context, 'itemPage');
          },
          child: const Tips(
            imgPath: 'assets/images/discount (3).png',
            nameService: 'CƠN LỐC KHUYẾN MÃI',
            descriptionService: 'Combo siêu ưu đãi tới mọi gia đình',
          ),
        ),
        InkWell(
          onTap: () {
            // Xử lý khi người dùng nhấp vào Tips 4
            Navigator.pushNamed(context, 'itemPage');
          },
          child: const Tips(
            imgPath: 'assets/images/discount (4).png',
            nameService: 'GIỜ VÀNG GIẢM GIÁ.',
            descriptionService: 'Coming Soon',
          ),
        ),
      ],
    );
  }
}
