import 'package:get/get.dart';
import 'package:moveinsync/data/repository/ride_repository.dart';

class RideController extends GetxController {
  final RideRepository rideRepo = Get.put(
    RideRepository(),
  ); 

  var isLoading = false.obs;
  var rideOptions = [].obs;

  // Fetch available vehicles & pricing from backend
  Future<void> fetchRideOptions(String from, String to) async {
    try {
      isLoading.value = true;
      var rides = await rideRepo.fetchRideOptions(from, to);
      rideOptions.value = rides;
    } catch (e) {
      print("Error fetching rides: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
