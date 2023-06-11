import 'package:bifat_app/Onboarding_Screen/intro_screen/intro_page1.dart';
import 'package:bifat_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller, // Thêm controller vào PageView
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(
                color: Colors.lightBlueAccent,
                imgPath: 'assets/images/mew1.gif',
              ),
              IntroPage1(
                color: Colors.cyanAccent,
                imgPath: 'assets/images/mew1.gif',
              ),
              IntroPage1(
                color: Colors.tealAccent,
                imgPath: 'assets/images/mew1.gif',
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),

                //next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:bifat_app/pages/login_page.dart';
// import 'package:bifat_app/styles/color.dart';
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';

// class OnBoardingScreen extends StatelessWidget {
//   OnBoardingScreen({super.key});

//   final List<PageViewModel> pages = [
//     PageViewModel(
//       back
//       title: 'First Page',
//       body: 'Description',
//       footer: ElevatedButton(
//         onPressed: () {},
//         child: const Text('go go'),
//       ),
//       image: Center(
//         child: Image.asset('assets/images/coming.jpg'),
//       ),
//       decoration: const PageDecoration(
//         titleTextStyle: TextStyle(
//           fontSize: 25,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//     PageViewModel(
//       title: 'Second Page',
//       body: 'Description',
//       footer: ElevatedButton(
//         onPressed: () {},
//         child: const Text('go go'),
//       ),
//       image: Center(
//         child: Image.asset('assets/images/coming.jpg'),
//       ),
//       decoration: const PageDecoration(
//         titleTextStyle: TextStyle(
//           fontSize: 25,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//     PageViewModel(
//       title: 'Third Page',
//       body: 'Description',
//       footer: ElevatedButton(
//         onPressed: () {},
//         child: const Text('go go'),
//       ),
//       image: Center(
//         child: Image.asset('assets/images/coming.jpg'),
//       ),
//       decoration: const PageDecoration(
//         titleTextStyle: TextStyle(
//           fontSize: 25,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('data'),
//         centerTitle: true,
//       ),
//       body: IntroductionScreen(
//         pages: pages,
//         dotsDecorator: const DotsDecorator(
//           size: Size(10, 10),
//           color: wBlue,
//           activeSize: Size.square(15),
//           activeColor: Colors.redAccent,
//         ),
//         showDoneButton: true,
//         done: const Text(
//           'Done',
//           style: TextStyle(fontSize: 20),
//         ),
//         showSkipButton: true,
//         skip: const Text(
//           'Skip',
//           style: TextStyle(fontSize: 20),
//         ),
//         showNextButton: true,
//         next: const Icon(Icons.arrow_circle_right_rounded, size: 20),
//         onDone: () => onDone(context),
//       ),
//     );
//   }

//   void onDone(context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const LoginPage(),
//       ),
//     );
//   }
// }
