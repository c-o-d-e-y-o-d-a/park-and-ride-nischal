import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:moveinsync/data/controller/ride_history_controller.dart';

class RideHistoryScreen extends StatelessWidget {
  final RideHistoryController controller = Get.put(RideHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ride History", style: TextStyle(color: Colors.white)),
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
                      hintText: "Search by Source/Destination...",
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

            // Ride History List
            Expanded(
              child: Obx(() {
                if (controller.filteredRides.isEmpty) {
                  return Center(
                    child: Text(
                      "No rides found.",
                      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.filteredRides.length,
                  itemBuilder: (context, index) {
                    final ride = controller.filteredRides[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ride.vehicleType,
                              style: TextStyle(
                                fontSize: 16.sp,
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
                                Text(
                                  "From: ${ride.source}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: Colors.grey,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "To: ${ride.destination}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "Fare: ₹${ride.fare}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "Date: ${DateFormat.yMMMd().format(ride.date)}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
