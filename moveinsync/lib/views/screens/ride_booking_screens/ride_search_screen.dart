import 'dart:developer';

import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:moveinsync/data/controller/ride_controller.dart';
import 'package:moveinsync/views/screens/ride_booking_screens/ride_confirmation_screen.dart';
import 'ride_results_screen.dart';

class RideSearchScreen extends StatefulWidget {
  const RideSearchScreen({super.key});

  @override
  State<RideSearchScreen> createState() => _RideSearchScreenState();
}

class _RideSearchScreenState extends State<RideSearchScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final RideController rideController = Get.find<RideController>();
  List<Suggestion> places = [];
  Suggestion? fromPlace;
  Suggestion? toPlace;
  SearchBoxAPI mapboxSearch = SearchBoxAPI(
    limit: 6,
  );
  List<String> dropdownMenuEntries = [
    'Bangalore',
    'Mumbai',
    'Delhi',
    'Chennai',
    'Kolkata',
    'Hyderabad',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Ride', style: TextStyle(color: Colors.white)),
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
                "Find Your Ride",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20.h),
              SearchableDropdown<String>(
                  inputDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'From',
                    prefixIcon: Icon(Icons.search),
                  ),
                  remoteItems: (search) async {
                    ApiResponse<SuggestionResponse> searchPlace =
                        await mapboxSearch.getSuggestions(search ?? "");
                    places = searchPlace.success?.suggestions ?? [];
                    return searchPlace.success?.suggestions
                            .map((e) => "${e.name}\n${e.fullAddress}")
                            .toList() ??
                        [searchPlace.failure?.error ?? ""];
                  },
                  itemLabelFormatter: (value) => value,
                  value: "china",
                  onChanged: (value) {
                    fromController.text = value ?? "";
                    fromPlace = places.firstWhere(
                        (element) => element.name == value?.split('\n')[0]);
                  }),
              SizedBox(height: 15.h),
              SearchableDropdown<String>(
                inputDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'From',
                  prefixIcon: Icon(Icons.search),
                ),
                remoteItems: (search) async {
                  ApiResponse<SuggestionResponse> searchPlace =
                      await mapboxSearch.getSuggestions(search ?? "");
                  places = searchPlace.success?.suggestions ?? [];
                  return searchPlace.success?.suggestions
                          .map((e) => "${e.name}\n${e.fullAddress}")
                          .toList() ??
                      [searchPlace.failure?.error ?? ""];
                },
                itemLabelFormatter: (value) => value,
                value: "china",
                onChanged: (value) {
                  toController.text = value ?? "";
                  toPlace = places.firstWhere(
                      (element) => element.name == value?.split('\n')[0]);
                },
              ),
              SizedBox(height: 25.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    rideController.fetchRideOptions(
                      fromController.text,
                      toController.text,
                    );
                    log("From: ${fromController.text}\n To: ${toController.text}");
                    // Get.to(() => RideConfirmationScreen(
                    //       from: fromController.text,
                    //       to: toController.text,
                    //       vehicle: "Car",
                    //       price: 1000.0,
                    //       fromPlace: fromPlace!,
                    //       toPlace: toPlace!,
                    //     ));
                    Get.to(
                      () => RideResultsScreen(
                        from: fromController.text,
                        to: toController.text,
                        fromPlace: fromPlace!,
                        toPlace: toPlace!,
                      ),
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
                    'Find Ride',
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
