import 'package:get/get.dart';
import 'package:moveinsync/views/screens/auth/login_screen.dart';
import 'package:moveinsync/views/screens/auth/signup_screen.dart';
import 'package:moveinsync/views/screens/coming_soon_screen.dart';
import 'package:moveinsync/views/screens/home/bottom_navigation_screen.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_available_screen.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_search_screen.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_slots_details.dart';
import 'package:moveinsync/views/screens/payments/payment_screen.dart';
import 'package:moveinsync/views/screens/ride_booking_screens/ride_history_screen.dart';
import 'package:moveinsync/views/screens/ride_booking_screens/ride_search_screen.dart';
import 'package:moveinsync/views/screens/ride_booking_screens/ride_results_screen.dart';
import 'package:moveinsync/views/screens/ride_booking_screens/ride_confirmation_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/home', page: () => BottomNavBarDashBoard()),
    GetPage(name: '/rideSearch', page: () => RideSearchScreen()),
    GetPage(
      name: '/rideResults',
      page: () => RideResultsScreen(
        from: Get.arguments['from'],
        to: Get.arguments['to'],
      ),
    ),

    GetPage(
      name: '/rideConfirmation',
      page: () => RideConfirmationScreen(
        from: Get.arguments['from'],
        to: Get.arguments['to'],
        vehicle: Get.arguments['vehicle'],
        price: Get.arguments['price'],
      ),
    ),
     GetPage(name: '/rideHistory', page: () => RideHistoryScreen()),
      GetPage(name: '/parkingSearch', page: () => ParkingSearchScreen()),
    GetPage(
      name: '/parkingResults',
      page:
          () =>
              ParkingResultsScreen(metroStation: Get.arguments['metroStation']),
    ),
     GetPage(
      name: '/soon',
      page:
          () =>
              const ComingSoonScreen(),
    ),
    GetPage(
      name: '/parkingSlots',
      page: () => ParkingSlotsScreen()
    ),
  ];
}
