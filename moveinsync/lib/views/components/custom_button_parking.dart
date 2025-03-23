import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/models/parking_spot_model.dart';
import 'package:moveinsync/views/screens/parking_booking_screens/parking_confrimation_screen.dart';

class ParkingBookingButton extends StatelessWidget {
  final ParkingSpot parkingSpot;

  const ParkingBookingButton({Key? key, required this.parkingSpot})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => ParkingConfirmationScreen(parkingSpot: parkingSpot));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Book Parking',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
