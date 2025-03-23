
import 'package:get/get.dart';
import 'package:moveinsync/models/parking_slot_model.dart';

class ParkingSlotsController extends GetxController {
  var searchQuery = ''.obs;
  var sortBy = 'Newest'.obs;
  var parkingSlots = <ParkingSlot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDummyParkingSlots();
  }

  void fetchDummyParkingSlots() {
    parkingSlots.value = [
      ParkingSlot(
        id: '1',
        location: 'DLF Mall Parking',
        vehicleType: 'Car',
        hours: 2,
        totalCost: 80,
        isActive: true,
      ),
      ParkingSlot(
        id: '2',
        location: 'Rajiv Chowk Parking',
        vehicleType: 'Bike',
        hours: 3,
        totalCost: 60,
        isActive: true,
      ),
      ParkingSlot(
        id: '3',
        location: 'Atta Market Parking',
        vehicleType: 'Car',
        hours: 1,
        totalCost: 40,
        isActive: false,
      ),
      ParkingSlot(
        id: '4',
        location: 'PVR Plaza Parking',
        vehicleType: 'Car',
        hours: 4,
        totalCost: 160,
        isActive: false,
      ),
    ];
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateSortBy(String value) {
    sortBy.value = value;
  }

  List<ParkingSlot> get filteredSlots {
    var filtered =
        parkingSlots
            .where(
              (slot) => slot.location.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ),
            )
            .toList();

    if (sortBy.value == 'Oldest') {
      filtered.sort((a, b) => a.id.compareTo(b.id));
    } else {
      filtered.sort((a, b) => b.id.compareTo(a.id));
    }

    return filtered;
  }
}
