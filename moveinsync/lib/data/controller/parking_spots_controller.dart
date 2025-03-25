import 'package:get/get.dart';
import 'package:moveinsync/data/repository/parking_repository.dart';
import 'package:moveinsync/models/parking_spot_model.dart';

class ParkingController extends GetxController {
  final ParkingRepository parkingRepository = ParkingRepository();

  var metroStations = <String>[].obs;
  var parkingList = <ParkingSpot>[].obs;
  var isLoading = false.obs;

  Future<List<String>> fetchMetroStations() async {
    isLoading.value = true;
    metroStations.value = await parkingRepository.getMetroStations();
    isLoading.value = false;

    return metroStations; // ✅ Return fetched metro stations
  }

  void fetchParkingData(String metroStation) async {
    isLoading.value = true;
    parkingList.value = await parkingRepository.getParkingSpots(metroStation);
    isLoading.value = false;
  }

  Future<bool> bookSlot({
    required String parkingSpotId,
    required String vehicleType, // "car" or "bike"
  }) async {
    bool result = await parkingRepository.bookParkingSlot(
      parkingSpotId: parkingSpotId,
      vehicleType: vehicleType,
    );

    if (result) {
    

      // ✅ Refresh UI after booking
      ParkingSpot updatedSpot = parkingList.firstWhere(
        (spot) => spot.id == parkingSpotId,
        orElse:
            () => ParkingSpot(
              id: "",
              metroStation: "",
              location: "",
              address: "",
              distance: 0.0,
              carRate: 0.0,
              bikeRate: 0.0,
              carSlots: 0,
              bikeSlots: 0,
            ),
      );

      if (updatedSpot.id.isNotEmpty) {
        if (vehicleType == "car") {
          updatedSpot = ParkingSpot(
            id: updatedSpot.id,
            metroStation: updatedSpot.metroStation,
            location: updatedSpot.location,
            address: updatedSpot.address,
            distance: updatedSpot.distance,
            carRate: updatedSpot.carRate,
            bikeRate: updatedSpot.bikeRate,
            carSlots: updatedSpot.carSlots - 1,
            bikeSlots: updatedSpot.bikeSlots,
          );
        } else if (vehicleType == "bike") {
          updatedSpot = ParkingSpot(
            id: updatedSpot.id,
            metroStation: updatedSpot.metroStation,
            location: updatedSpot.location,
            address: updatedSpot.address,
            distance: updatedSpot.distance,
            carRate: updatedSpot.carRate,
            bikeRate: updatedSpot.bikeRate,
            carSlots: updatedSpot.carSlots,
            bikeSlots: updatedSpot.bikeSlots - 1,
          );
        }

        parkingList.removeWhere((spot) => spot.id == parkingSpotId);
        parkingList.add(updatedSpot);
        parkingList.refresh();
      }

      return true;
    } else {
      Get.snackbar("Error", "Failed to book parking slot");
      return false;
    }
  }
}
