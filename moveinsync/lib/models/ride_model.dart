class Ride {
  final String id;
  final String userId;
  final String from;
  final String to;
  final String vehicle;
  final double price;
  final String status;
  final String timestamp;

  Ride({
    required this.id,
    required this.userId,
    required this.from,
    required this.to,
    required this.vehicle,
    required this.price,
    required this.status,
    required this.timestamp,
  });

  factory Ride.fromMap(Map<String, dynamic> data) {
    return Ride(
      id: data['\$id'] ?? '',
      userId: data['userId'] ?? '',
      from: data['from'] ?? '',
      to: data['to'] ?? '',
      vehicle: data['vehicle'] ?? '',
      price: data['price'].toDouble() ?? 220,
      status: data['status'] ?? '',
      timestamp: data['timestamp'] ?? '',
    );
  }
}
