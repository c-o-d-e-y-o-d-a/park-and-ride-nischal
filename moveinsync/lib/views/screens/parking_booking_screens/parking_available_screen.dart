import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/parking_spots_controller.dart';
import 'package:moveinsync/models/parking_spot_model.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_confrimation_screen.dart';

class ParkingResultsScreen extends StatelessWidget {
  final String metroStation;
  final ParkingController parkingController = Get.find<ParkingController>();

  ParkingResultsScreen({Key? key, required this.metroStation})
    : super(key: key) {
    parkingController.fetchParkingData(metroStation); // Fetch parking spots
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parking Near $metroStation',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
              final ParkingSpot parking = parkingController.parkingList[index];

              bool hasCarSlots = parking.carSlots > 0;
              bool hasBikeSlots = parking.bikeSlots > 0;
              bool hasAnySlots = hasCarSlots || hasBikeSlots;

              return Card(
                margin: EdgeInsets.only(bottom: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        parking.location,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      /// **Address**
                      Text(
                        parking.address,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),

                      SizedBox(height: 10.h),
                      Divider(color: Colors.grey.shade300, thickness: 1),

                      SizedBox(height: 8.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.directions_car, color: Colors.blue),
                              SizedBox(width: 6.w),
                              Text(
                                "₹${parking.carRate}/hr • ${parking.carSlots} slots",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      hasCarSlots ? Colors.black : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.two_wheeler, color: Colors.green),
                              SizedBox(width: 6.w),
                              Text(
                                "₹${parking.bikeRate}/hr • ${parking.bikeSlots} slots",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      hasBikeSlots ? Colors.black : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                hasAnySlots
                                    ? Colors.blue.shade600
                                    : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          onPressed:
                              hasAnySlots
                                  ? () {
                                    Get.to(
                                      () => ParkingConfirmationScreen(
                                        parkingSpot: parking,
                                      ),
                                    );
                                  }
                                  : null,
                          child: Text(
                            hasAnySlots ? "Book Now" : "No Slots Available",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
