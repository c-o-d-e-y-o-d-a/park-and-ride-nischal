class ParkingSpot {
  final String id;
  final String metroStation;
  final String location;
  final String address;
  final double distance; // Distance from metro station in km
  final Map<String, double>
  vehicleRates; // Rates per hour for different vehicles

  ParkingSpot({
    required this.id,
    required this.metroStation,
    required this.location,
    required this.address,
    required this.distance,
    required this.vehicleRates,
  });

  factory ParkingSpot.fromMap(Map<String, dynamic> data) {
    return ParkingSpot(
      id: data['id'],
      metroStation: data['metroStation'],
      location: data['location'],
      address: data['address'],
      distance: data['distance'].toDouble(),
      vehicleRates: Map<String, double>.from(data['vehicleRates']),
    );
  }
}
