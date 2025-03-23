import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moveinsync/models/ride_model.dart';

class RideRepository {
  late final Client _client;
  late final Databases _database;

  RideRepository() {
    _client =
        Client()
          ..setEndpoint('https://cloud.appwrite.io/v1') 
          ..setProject(dotenv.env['PROJECT_ID']);

    _database = Databases(_client);
  }

  Future<List<Ride>> fetchRideOptions(String from, String to) async {
    try {
      final response = await _database.listDocuments(
        databaseId: '67dfb51d0010bb70d103',
        collectionId: '67dfb56100186b612389',
queries: [Query.search('from', from), Query.search('to', to)],
      );

      return response.documents.map((doc) => Ride.fromMap(doc.data)).toList();
    } catch (e) {
      print("Error fetching ride prices: $e");
      return [];
    }
  }


  Future<void> bookRide(
    String userId,
    String from,
    String to,
    String vehicle,
    double price,
  ) async {
    try {
      await _database.createDocument(
        databaseId: '67dfb51d0010bb70d103',
        collectionId: '67dfc64300092490b7e0',
        documentId: ID.unique(),
        data: {
          "userId": userId,
          "from": from,
          "to": to,
          "vehicle": vehicle,
          "price": price,
          "status": "Booked",
          "timestamp": DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      print("Error booking ride: $e");
    }
  }
}
