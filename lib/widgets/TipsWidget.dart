import 'package:flutter/material.dart';

import '../components/Tips.dart';

class TipWidget extends StatelessWidget {
  const TipWidget({super.key});

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
            imgPath: 'assets/images/tip (1).png',
            nameService:
                '4 cách ít người biết để tẩy mốc trên áo phao.',
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
            imgPath: 'assets/images/tip (2).png',
            nameService: 'Cách giặt áo Hoodie không bị nhăn.',
            descriptionService: 'Sự lựa chọn tiết kiệm cho gia đình',
          ),
        ),
        InkWell(
          onTap: () {
            // Xử lý khi người dùng nhấp vào Tips 3
            Navigator.pushNamed(context, 'itemPage');
          },
          child: const Tips(
            imgPath: 'assets/images/tip (3).png',
            nameService: 'Cách xử lý thảm khi bị mỡ, bùn đất...dính.',
            descriptionService: 'Combo siêu ưu đãi tới mọi gia đình',
          ),
        ),
        InkWell(
          onTap: () {
            // Xử lý khi người dùng nhấp vào Tips 4
            Navigator.pushNamed(context, 'itemPage');
          },
          child: const Tips(
            imgPath: 'assets/images/tip (4).png',
            nameService: 'Cách loại bỏ vết ố vàng ở áo thun trắng.',
            descriptionService: 'Coming Soon',
          ),
        ),
      ],
    );
  }
}
