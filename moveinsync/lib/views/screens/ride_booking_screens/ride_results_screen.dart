import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:moveinsync/data/controller/ride_controller.dart';
import 'package:moveinsync/models/ride_model.dart';

class RideResultsScreen extends StatelessWidget {
  final String from;
  final String to;
  final RideController rideController = Get.find<RideController>();
  final Suggestion fromPlace;
  final Suggestion toPlace;

  RideResultsScreen(
      {Key? key,
      required this.from,
      required this.to,
      required this.fromPlace,
      required this.toPlace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    rideController.fetchRideOptions(from, to);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a Ride',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Obx(() {
          if (rideController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (rideController.rideOptions.isEmpty) {
            return Center(child: Text("No rides available for this route"));
          }

          return ListView.builder(
            itemCount: rideController.rideOptions.length,
            itemBuilder: (context, index) {
              final Ride ride = rideController.rideOptions[index];

              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/rideConfirmation',
                    arguments: {
                      'from': ride.from,
                      'to': ride.to,
                      'vehicle': ride.vehicle,
                      'price': ride.price,
                      'fromPlace': fromPlace,
                      'toPlace': toPlace,
                    },
                  );
                },
                child: Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12.w),
                    leading: Icon(
                      Icons.directions_car,
                      size: 30.sp,
                      color: Colors.blue,
                    ),
                    title: Text(
                      ride.vehicle,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
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
