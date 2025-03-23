import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 80.w,
       title:  Text(
          "MoveInSync",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner, size: 27.sp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, size: 27.sp),
            onPressed: () {},
          ),
          InkWell(
            onTap: (){
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CircleAvatar(
                radius: 17.r,
                backgroundImage: AssetImage('assets/user_profile.png'),
              ),
            ),
          ),
          SizedBox(width: 5.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              SizedBox(
                height: 55.h,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 239, 239, 239),
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              // Smart Policy Choice Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/taxi.png',
                      height: 120.h,
                      width: 120.w,
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ride with Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '  Get the best deals \n on rides',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Divider(
                color: const Color.fromARGB(255, 226, 225, 225),
                thickness: 6,
              ),
              SizedBox(height: 8.h),

              // Services Section
              _sectionTitle("Services"),
              SizedBox(height: 16.h),
              _gridItems([
                {'icon': Icons.directions_car, 'text': 'Book a Ride', 'route': '/rideSearch'},
                {'icon': Icons.local_taxi, 'text': 'Book Parking', 'route':'/parkingSearch'},
                {'icon': Icons.local_parking, 'text': 'Parking Slots',
                  'route': '/parkingSlots',
                },
                {'icon': Icons.receipt, 'text': 'Payments', 'route': '/'},
              ]),
              SizedBox(height: 15.h),

              Divider(
                color: const Color.fromARGB(255, 226, 225, 225),
                thickness: 6,
              ),
              SizedBox(height: 15.h),

              // View Section
              _sectionTitle("View"),
              SizedBox(height: 16.h),
              _gridItems([
                {'icon': Icons.history, 'text': 'Ride History', 'route': '/rideHistory'},
                {'icon': Icons.event, 'text': 'Metro', 'route': '/'},
                {'icon': Icons.report, 'text': 'Reports', 'route': '/'},
              ]),
              SizedBox(height: 15.h),

              

              Divider(
                color: const Color.fromARGB(255, 226, 225, 225),
                thickness: 6,
              ),
              SizedBox(height: 15.h),

              // Calculators Section
            
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 4.w),
            height: 1,
            color: Colors.blue,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 4.w),
            height: 1,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  // Function to create grid items
  Widget _gridItems(List<Map<String, dynamic>> items) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children:
          items.map((item) {
            return InkWell(
              onTap: () {
                Get.toNamed(item['route']);

              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 65.h,
                    width: 90.w,
                    child: Center(
                      child: Icon(
                        item['icon'],
                        size: 40.sp,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item['text'],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
