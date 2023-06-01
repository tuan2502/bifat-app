import 'package:flutter/material.dart';
import '../components/ServiceMore.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'laundryPage');
            },
            child: const ServiceMore(
              imgPath: 'assets/images/bifat (2).png',
              nameService: 'Giặt ủi thường',
              descriptionService:
                  'Giặt theo kí - sự lựa chọn của mọi nhà',
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'combo1Page');
            },
            child: const ServiceMore(
              imgPath: 'assets/images/bifat (5).png',
              nameService: 'Giặt ủi Combo 1',
              descriptionService: 'Sự lựa chọn tiết kiệm cho gia đình',
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'combo2Page');
            },
            child: const ServiceMore(
              imgPath: 'assets/images/bifat (2).png',
              nameService: 'Giặt ủi Combo 2',
              descriptionService: 'Combo siêu ưu đãi tới mọi gia đình',
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'servicePage');
            },
            child: const ServiceMore(
              imgPath: 'assets/images/coming.jpg',
              nameService: 'Coming Soon',
              descriptionService: 'Coming Soon',
            ),
          ),
          // Add more InkWell widgets for additional items
        ],
      ),
    );
  }
}
