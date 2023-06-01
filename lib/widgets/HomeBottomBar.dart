import 'package:flutter/material.dart';

import '../styles/color.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: wPurBlue,
        //color: Color.fromRGBO(216, 191, 154, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              //...
            },
            child: const Icon(
              Icons.home_outlined,
              color: wBlack,
              size: 32,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'cartPage');
            },
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: wBlack,
              size: 32,
            ),
          ),
          InkWell(
            onTap: () {
              //..
            },
            child: const Icon(
              Icons.chat_bubble_outline,
              color: wBlack,
              size: 32,
            ),
          ),
          InkWell(
            onTap: () {
            },
            child: const Icon(
              Icons.list_alt_rounded,
              color: wBlack,
              size: 32,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'profilePage');
            },
            child: const Icon(
              Icons.account_box_outlined,
              color: wBlack,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}