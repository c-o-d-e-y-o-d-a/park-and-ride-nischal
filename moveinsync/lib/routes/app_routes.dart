import 'package:get/get.dart';
import 'package:moveinsync/views/screens/auth/login_screen.dart';
import 'package:moveinsync/views/screens/auth/signup_screen.dart';
import 'package:moveinsync/views/screens/home/bottom_navigation_screen.dart';
import 'package:moveinsync/views/screens/home/home_screen.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/home', page: () => BottomNavBarDashBoard()),
       GetPage(name: '/signup', page: () => SignUpScreen()),
  ];
}
