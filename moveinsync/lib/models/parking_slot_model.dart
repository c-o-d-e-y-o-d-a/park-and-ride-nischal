class ParkingSlot {
  final String id;
  final String location;
  final String vehicleType;
  final int hours;
  final double totalCost;
  final bool isActive;

  ParkingSlot({
    required this.id,
    required this.location,
    required this.vehicleType,
    required this.hours,
    required this.totalCost,
    required this.isActive,
  });
}
