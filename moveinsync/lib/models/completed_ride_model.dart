class RideHistory {
  final String id;
  final String vehicleType;
  final double fare;
  final String source;
  final String destination;
  final DateTime date;

  RideHistory({
    required this.id,
    required this.vehicleType,
    required this.fare,
    required this.source,
    required this.destination,
    required this.date,
  });
}
