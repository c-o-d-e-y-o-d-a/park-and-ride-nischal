import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/parking_spots_controller.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_confrimation_screen.dart';

class ParkingResultsScreen extends StatelessWidget {
  final String metroStation;
  final ParkingController parkingController = Get.find<ParkingController>();

  ParkingResultsScreen({Key? key, required this.metroStation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parking Near $metroStation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (parkingController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (parkingController.parkingList.isEmpty) {
            return const Center(
              child: Text(
                "No parking available for this metro station",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: parkingController.parkingList.length,
            itemBuilder: (context, index) {
              final parking = parkingController.parkingList[index];

              return InkWell(
                onTap: () {
                  Get.to(() => ParkingConfirmationScreen(parkingSpot: parking));
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parking.location,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: Text(
                                parking.address,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_walk,
                              color: Colors.grey,
                              size: 20.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "${parking.distance} km away",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        SizedBox(height: 10.h),
                        Text(
                          "Vehicle Rates (Per Hour)",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: Colors.blue,
                              size: 20.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Car: ₹${parking.vehicleRates["Car"]}/hr",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(
                              Icons.two_wheeler,
                              color: Colors.blue,
                              size: 20.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "Bike: ₹${parking.vehicleRates["Bike"]}/hr",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
