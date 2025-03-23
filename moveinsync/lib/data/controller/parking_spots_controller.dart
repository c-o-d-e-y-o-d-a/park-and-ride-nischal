import 'package:get/get.dart';
import 'package:moveinsync/models/parking_spot_model.dart';

class ParkingController extends GetxController {
  var parkingList = <ParkingSpot>[].obs;
  var isLoading = false.obs;

  final List<String> metroStations = ["Noida Sector 18", "Rajiv Chowk"];

  final Map<String, List<ParkingSpot>> sampleData = {
    "Noida Sector 18": [
      ParkingSpot(
        id: "1",
        metroStation: "Noida Sector 18",
        location: "DLF Mall Parking",
        address: "DLF Mall, Noida",
        distance: 0.5,
        vehicleRates: {"Car": 40.0, "Bike": 20.0},
      ),
      ParkingSpot(
        id: "2",
        metroStation: "Noida Sector 18",
        location: "Atta Market Parking",
        address: "Near Atta Market, Noida",
        distance: 0.8,
        vehicleRates: {"Car": 30.0, "Bike": 15.0},
      ),
    ],
    "Rajiv Chowk": [
      ParkingSpot(
        id: "3",
        metroStation: "Rajiv Chowk",
        location: "Connaught Place Parking",
        address: "Connaught Place, Delhi",
        distance: 0.4,
        vehicleRates: {"Car": 50.0, "Bike": 25.0},
      ),
      ParkingSpot(
        id: "4",
        metroStation: "Rajiv Chowk",
        location: "PVR Plaza Parking",
        address: "Near PVR Plaza, Delhi",
        distance: 0.7,
        vehicleRates: {"Car": 45.0, "Bike": 22.0},
      ),
    ],
  };

  void fetchParkingData(String metroStation) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading
    parkingList.value = sampleData[metroStation] ?? [];
    isLoading.value = false;
  }
}
