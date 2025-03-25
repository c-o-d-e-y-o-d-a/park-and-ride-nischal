import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';



class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Our App",
          body: "Discover new features and seamless experience.",
          image: Center(
            child: Icon(Icons.mobile_friendly),
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Stay Connected",
          body: "Engage with your favorite services anytime, anywhere.",
          image: Center(
            child: Icon(Icons.notifications_active),
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Get Started Now",
          body: "Sign up today and explore a world of possibilities!",
          image: Center(
            child: Icon(Icons.car_rental_sharp),
          ),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
      onDone: () => goToHome(context),
      showSkipButton: true,
      skip: Text("Skip"),
      next: Icon(Icons.arrow_forward),
      dotsDecorator: DotsDecorator(
        size: Size(10, 10),
        color: Colors.grey,
        activeSize: Size(22, 10),
        activeColor: Colors.blue,
        spacing: EdgeInsets.symmetric(horizontal: 3),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      globalBackgroundColor: Colors.white,
    );
  }

  void goToHome(BuildContext context) {
   Get.toNamed("/login");
  }

  PageDecoration getPageDecoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16),
      imagePadding: EdgeInsets.all(24),
    );
  }
}




