import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/parking_spots_controller.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_available_screen.dart';
import 'package:searchfield/searchfield.dart';

class ParkingSearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final ParkingController parkingController = Get.put(ParkingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Metro Parking',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          width: 330.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Find Parking Near Metro",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20.h),

              // SearchField for Metro Station Search
              SearchField(
                controller: searchController,
                suggestions:
                    parkingController.metroStations
                        .map((station) => SearchFieldListItem(station))
                        .toList(),
                suggestionStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black54,
                ),
                
              ),
              SizedBox(height: 25.h),

              // Search Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      parkingController.fetchParkingData(searchController.text);
                      Get.to(
                        () => ParkingResultsScreen(
                          metroStation: searchController.text,
                        ),
                      );
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please enter a metro station",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Find Parking',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
