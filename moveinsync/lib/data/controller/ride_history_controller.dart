import 'package:get/get.dart';
import 'package:moveinsync/models/completed_ride_model.dart';

class RideHistoryController extends GetxController {
  var searchQuery = ''.obs;
  var sortBy = 'Newest'.obs;
  var rideHistory = <RideHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDummyRideHistory();
  }

  void fetchDummyRideHistory() {
    rideHistory.value = [
      RideHistory(
        id: '1',
        vehicleType: 'Sedan',
        fare: 150.0,
        source: 'Connaught Place',
        destination: 'Noida',
        date: DateTime.now().subtract(Duration(days: 2)),
      ),
      RideHistory(
        id: '2',
        vehicleType: 'SUV',
        fare: 220.0,
        source: 'Rajiv Chowk',
        destination: 'Gurgaon',
        date: DateTime.now().subtract(Duration(days: 5)),
      ),
      RideHistory(
        id: '3',
        vehicleType: 'Bike',
        fare: 80.0,
        source: 'Lajpat Nagar',
        destination: 'South Delhi',
        date: DateTime.now().subtract(Duration(days: 8)),
      ),
    ];
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateSortBy(String value) {
    sortBy.value = value;
  }

  List<RideHistory> get filteredRides {
    var filtered =
        rideHistory
            .where(
              (ride) =>
                  ride.source.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ) ||
                  ride.destination.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList();

    if (sortBy.value == 'Oldest') {
      filtered.sort((a, b) => a.date.compareTo(b.date));
    } else {
      filtered.sort((a, b) => b.date.compareTo(a.date));
    }

    return filtered;
  }
}
