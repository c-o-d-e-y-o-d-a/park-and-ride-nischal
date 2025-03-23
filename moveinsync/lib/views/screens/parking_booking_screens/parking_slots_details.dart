import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/parking_slots_controller.dart';
import 'package:moveinsync/models/parking_slot_model.dart';

class ParkingSlotsScreen extends StatelessWidget {
  final ParkingSlotsController controller = Get.put(ParkingSlotsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Parking Slots", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Search & Sort Options
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: "Search Parking...",
                      prefixIcon: Icon(Icons.search, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                DropdownButton<String>(
                  value: controller.sortBy.value,
                  items:
                      ["Newest", "Oldest"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) controller.updateSortBy(value);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Parking Slots List
            Expanded(
              child: Obx(() {
                List<ParkingSlot> activeSlots =
                    controller.filteredSlots
                        .where((slot) => slot.isActive)
                        .toList();
                List<ParkingSlot> oldSlots =
                    controller.filteredSlots
                        .where((slot) => !slot.isActive)
                        .toList();

                return ListView(
                  children: [
                    if (activeSlots.isNotEmpty)
                      _sectionTitle("Current Active Slots"),
                    ...activeSlots.map((slot) => _parkingSlotCard(slot)),
                    SizedBox(height: 20.h),

                    if (oldSlots.isNotEmpty) _sectionTitle("Old Slots(Expired)"),
                    ...oldSlots.map((slot) => _parkingSlotCard(slot)),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  // Parking Slot Card
  Widget _parkingSlotCard(ParkingSlot slot) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              slot.location,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.directions_car, color: Colors.grey, size: 20.sp),
                SizedBox(width: 5.w),
                Text(
                  "Vehicle: ${slot.vehicleType}",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey, size: 20.sp),
                SizedBox(width: 5.w),
                Text(
                  "Duration: ${slot.hours} hr${slot.hours > 1 ? 's' : ''}",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.grey, size: 20.sp),
                SizedBox(width: 5.w),
                Text(
                  "Total: ₹${slot.totalCost}",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
