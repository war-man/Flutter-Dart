import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../constants.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}
final _controller = PageController(
  initialPage: 0,
);

int currentPage = 0;

List<Widget> _pages = [
  Column(
    children: [
      Expanded(child: Image.asset('images/enteraddress.png')),
      Text("Set Your Delivery Location",style: kPageViewTextStyle,textAlign: TextAlign.center,)
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/deliverfood.png')),
      Text("Quick deliver to your Doorstep",style: kPageViewTextStyle,textAlign: TextAlign.center)
    ],
  ),
  Column(
    children: [
      Expanded(child: Image.asset('images/orderfood.png')),
      Text("Order Online from your favorite store",style: kPageViewTextStyle,textAlign: TextAlign.center)
    ],
  )
];
class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    print("OnBoard Screen Starting ...");
    print("Current Page => 0");
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index){
              setState(() {
                currentPage = index;
                print("----> ${currentPage.toDouble()}");
              });

            },
            )
          ),
          SizedBox(height: 20),
          DotsIndicator(
            dotsCount: _pages.length,
            position: currentPage.toDouble(),
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0,9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.deepOrange
            ),
          ),
          SizedBox(height: 20)
        ]
      ),
    );
  }
}
