import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_search/mapbox_search.dart';

class RideConfirmationScreen extends StatefulWidget {
  final String from;
  final String to;
  final String vehicle;

  final Suggestion fromPlace;
  final Suggestion toPlace;

  const RideConfirmationScreen({
    Key? key,
    required this.from,
    required this.to,
    required this.vehicle,
    required this.fromPlace,
    required this.toPlace,
  }) : super(key: key);

  @override
  State<RideConfirmationScreen> createState() => _RideConfirmationScreenState();
}

class _RideConfirmationScreenState extends State<RideConfirmationScreen> {
  SearchBoxAPI search = SearchBoxAPI(
    limit: 6,
  );
  StaticImage staticImage = StaticImage();
  Coordinates? fromCoords;
  Coordinates? toCoords;
  Map<String, dynamic> directionsMatrix = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      ApiResponse<RetrieveResonse> fromSearchPlace =
          await search.getPlace(widget.fromPlace.mapboxId);
      ApiResponse<RetrieveResonse> toSearchPlace =
          await search.getPlace(widget.toPlace.mapboxId);
      fromCoords = fromSearchPlace.success?.features[0].properties.coordinates;
      toCoords = toSearchPlace.success?.features[0].properties.coordinates;
      setState(() {});
      await fetchDirectionsMatrix();
    });
  }

  Future<void> fetchDirectionsMatrix() async {
    final String url =
        "https://api.mapbox.com/directions-matrix/v1/mapbox/driving/"
        "${fromCoords!.location.long},${fromCoords!.location.lat};${toCoords!.location.long},${toCoords!.location.lat}"
        "?sources=1&annotations=distance,duration"
        "&access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Response: $data");
        directionsMatrix = data as Map<String, dynamic>;
        setState(() {});
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Uri getStaticImageWithPolyline() => staticImage.getStaticUrlWithPolyline(
        point1: fromCoords!.location,
        point2: toCoords!.location,
        auto: true,
        path: MapBoxPath(
            pathColor: RgbColor(255, 0, 0),
            pathWidth: 20,
            pathPolyline: '20',
            pathOpacity: 100),
        height: 300,
        width: 600,
        zoomLevel: 16,
      );

  @override
  Widget build(BuildContext context) {
    return fromCoords == null || toCoords == null || directionsMatrix.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Ride Confirmed',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Ride Confirmed',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                        Icon(Icons.question_mark_outlined,
                            size: 60, color: Colors.red),
                        SizedBox(height: 10),
                        Text(
                          "Confirm Ride",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 20),
                        _rideDetail("From", widget.from.split('\n')[0]),
                        _rideDetail("To", widget.to.split('\n')[0]),
                        _rideDetail("Vehicle", widget.vehicle),
                        _rideDetail("Price",
                            "Rs ${30 + (directionsMatrix['distances']![0][0] / 1000) * 7}"),
                        _rideDetail("Distance",
                            "${(directionsMatrix['distances']![0][0] / 1000).toStringAsFixed(2)} km"),
                        _rideDetail("Duration",
                            "${(directionsMatrix['durations']![0][0] / 60).toStringAsFixed(0)} mins"),
                        SizedBox(height: 25),

                        // Finish Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.showSnackbar(GetSnackBar(
                                title: 'Ride Booking Confirmed',
                                message: 'Your booking has been confirmed',
                              ));
                              Get.offAllNamed('/home');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: Text("Confirm",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            getStaticImageWithPolyline().toString())),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _rideDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
