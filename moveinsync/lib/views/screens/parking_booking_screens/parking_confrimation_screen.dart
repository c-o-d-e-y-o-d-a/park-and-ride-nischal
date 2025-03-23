import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/models/parking_spot_model.dart';
import 'package:moveinsync/views/screens/payments/payment_screen.dart';

class ParkingConfirmationScreen extends StatefulWidget {
  final ParkingSpot parkingSpot;

  const ParkingConfirmationScreen({Key? key, required this.parkingSpot})
    : super(key: key);

  @override
  _ParkingConfirmationScreenState createState() =>
      _ParkingConfirmationScreenState();
}

class _ParkingConfirmationScreenState extends State<ParkingConfirmationScreen> {
  String selectedVehicle = "Car";
  int selectedHours = 1;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    setState(() {
      totalPrice =
          (widget.parkingSpot.vehicleRates[selectedVehicle] ?? 0.0) *
          selectedHours;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Parking',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parking Location
            Text(
              widget.parkingSpot.location,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey, size: 20.sp),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    widget.parkingSpot.address,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),

            // Vehicle Type Selection
            Text(
              "Select Vehicle Type",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _vehicleOption("Car"),
                SizedBox(width: 10.w),
                _vehicleOption("Bike"),
              ],
            ),
            SizedBox(height: 20.h),

            // Hour Selection
            Text(
              "Select Number of Hours",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            DropdownButton<int>(
              value: selectedHours,
              items:
                  List.generate(24, (index) => index + 1)
                      .map(
                        (hour) => DropdownMenuItem(
                          value: hour,
                          child: Text("$hour hour${hour > 1 ? 's' : ''}"),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedHours = value!;
                  _calculateTotal();
                });
              },
            ),
            SizedBox(height: 20.h),

            // Total Price
            Text(
              "Total Price: ₹$totalPrice",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 60.h),

            // Pay Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(PaymentScreen(amount: totalPrice));
                  Get.snackbar(
                    "Payment",
                    "Proceeding to Payment of ₹$totalPrice",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Pay Now',
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
    );
  }

  // Custom Vehicle Selection Widget
  Widget _vehicleOption(String vehicle) {
    bool isSelected = selectedVehicle == vehicle;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicle = vehicle;
          _calculateTotal();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(
              vehicle == "Car" ? Icons.directions_car : Icons.two_wheeler,
              color: isSelected ? Colors.white : Colors.black54,
            ),
            SizedBox(width: 8.w),
            Text(
              vehicle,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
