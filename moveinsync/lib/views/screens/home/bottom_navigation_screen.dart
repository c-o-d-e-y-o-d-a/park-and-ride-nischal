import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moveinsync/views/screens/home/home_screen.dart';
import 'package:moveinsync/views/screens/home/profile_screen.dart';

class BottomNavBarDashBoard extends StatefulWidget {
  const BottomNavBarDashBoard({super.key});

  @override
  _BottomNavBarDashBoardState createState() => _BottomNavBarDashBoardState();
}

class _BottomNavBarDashBoardState extends State<BottomNavBarDashBoard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    Container(color: Colors.green),
    Container(color: Colors.blue),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 0
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.home,
                  size: 22.sp,
                  color: _currentIndex == 0 ? Colors.blue : Colors.grey,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 1
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.car_rental,
                  size: 22.sp,
                  color: _currentIndex == 1 ? Colors.blue : Colors.grey,
                ),
              ),
              label: 'Rides',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 2
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.local_parking,
                  size: 22.sp,
                  color: _currentIndex == 2 ? Colors.blue : Colors.grey,
                ),
              ),
              label: 'Parkings',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color:
                      _currentIndex == 3
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.person,
                  size: 22.sp,
                  color: _currentIndex == 3 ? Colors.blue : Colors.grey,
                ),
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0, // Removes default shadow
        ),
      ),
    );
  }
}
