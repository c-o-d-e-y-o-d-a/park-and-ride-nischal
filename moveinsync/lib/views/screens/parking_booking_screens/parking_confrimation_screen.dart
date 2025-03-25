import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/parking_spots_controller.dart';
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
  final ParkingController parkingController = Get.find<ParkingController>();

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
      if (selectedVehicle == "Car") {
        totalPrice = widget.parkingSpot.carRate * selectedHours;
      } else {
        totalPrice = widget.parkingSpot.bikeRate * selectedHours;
      }
    });
  }

  void _confirmBooking() async {
    bool success = await parkingController.bookSlot(
      parkingSpotId: widget.parkingSpot.id,
      vehicleType: selectedVehicle.toLowerCase(), 
    );

    if (success) {
      Get.to(() => PaymentScreen(amount: totalPrice, onPaymentSuccess: (){
        Get.back();
        Get.back();
        Get.snackbar(
          "Success",
          "Parking booked successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
      },));
     
    } else {
      Get.snackbar(
        "Error",
        "No available slots for $selectedVehicle.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int availableSlots =
        selectedVehicle == "Car"
            ? widget.parkingSpot.carSlots
            : widget.parkingSpot.bikeSlots;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Parking',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location
            Text(
              widget.parkingSpot.location,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.h),

            // Address
            Text(
              widget.parkingSpot.address,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 20.h),

            // Vehicle Type Selection
            Text("Select Vehicle Type:", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedVehicle = "Car";
                        _calculateTotal();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedVehicle == "Car"
                              ? Colors.blue
                              : Colors.grey[300],
                    ),
                    child: Text("Car"),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedVehicle = "Bike";
                        _calculateTotal();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedVehicle == "Bike"
                              ? Colors.blue
                              : Colors.grey[300],
                    ),
                    child: Text("Bike"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Parking Rate
            Text(
              "Rate per hour: ₹${selectedVehicle == "Car" ? widget.parkingSpot.carRate : widget.parkingSpot.bikeRate}",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.h),

            // Available Slots
            Text(
              "Available Slots: $availableSlots",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: availableSlots > 0 ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 20.h),

            // Hours Dropdown
            Text("Select Duration:", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 8.h),
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

            // Confirm Button
            ElevatedButton(
              onPressed: availableSlots > 0 ? _confirmBooking : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: availableSlots > 0 ? Colors.blue : Colors.grey,
              ),
              child: Text(
                availableSlots > 0
                    ? "Pay ₹$totalPrice Now"
                    : "No Slots Available",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
