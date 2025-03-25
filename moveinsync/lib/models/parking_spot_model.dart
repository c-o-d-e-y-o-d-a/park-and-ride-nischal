class ParkingSpot {
  final String id;
  final String metroStation;
  final String location;
  final String address;
  final double distance; // Distance from metro station in km

  // Prices per hour
  final double carRate;
  final double bikeRate;

  // Available slots
  final int carSlots;
  final int bikeSlots;

  ParkingSpot({
    required this.id,
    required this.metroStation,
    required this.location,
    required this.address,
    required this.distance,
    required this.carRate,
    required this.bikeRate,
    required this.carSlots,
    required this.bikeSlots,
  });

  factory ParkingSpot.fromMap(Map<String, dynamic> data) {
    return ParkingSpot(
      id: data['\$id'],
      metroStation: data['metroStation'],
      location: data['location'],
      address: data['address'],
      distance: (data['distance'] as num).toDouble(),
      carRate: (data['carRate'] as num).toDouble(),
      bikeRate: (data['bikeRate'] as num).toDouble(),
      carSlots: data['carSlots'] as int,
      bikeSlots: data['bikeSlots'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metroStation': metroStation,
      'location': location,
      'address': address,
      'distance': distance,
      'carRate': carRate,
      'bikeRate': bikeRate,
      'carSlots': carSlots,
      'bikeSlots': bikeSlots,
    };
  }
}
