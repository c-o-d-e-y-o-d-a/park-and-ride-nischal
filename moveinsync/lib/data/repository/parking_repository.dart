import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moveinsync/models/parking_spot_model.dart';

class ParkingRepository {
  late final Databases database;

  ParkingRepository() {
    Client client = Client()
        .setEndpoint(
          'https://cloud.appwrite.io/v1',
        ) 
        .setProject(dotenv.env['PROJECT_ID'])
        .setSelfSigned(status: true);

    database = Databases(client);
  }


  Future<List<String>> getMetroStations() async {
    try {
      final models.DocumentList response = await database.listDocuments(
        databaseId: '67dfb51d0010bb70d103',
        collectionId: '67e2f538000c3522aa11',
      );

      return response.documents
          .map((doc) => doc.data['name'].toString())
          .toList();
    } catch (e) {
      print("Error fetching metro stations: $e");
      return [];
    }
  }

  /// Fetch list of parking spots near a metro station
  Future<List<ParkingSpot>> getParkingSpots(String metroStation) async {
    try {
      final models.DocumentList response = await database.listDocuments(
        databaseId: '67dfb51d0010bb70d103',
        collectionId: '67e2f54c003d583b1c45',
        queries: [Query.equal('metroStation', metroStation)],
      );

      return response.documents
          .map((doc) => ParkingSpot.fromMap(doc.data))
          .toList();
    } catch (e) {
      print("Error fetching parking spots: $e");
      return [];
    }
  }

  Future<bool> bookParkingSlot({
    required String parkingSpotId,
    required String vehicleType, 
  }) async {
    try {
      final models.Document doc = await database.getDocument(
        databaseId: '67dfb51d0010bb70d103',
        collectionId: '67e2f54c003d583b1c45',
        documentId: parkingSpotId,
      );

      Map<String, dynamic> data = doc.data;
      int carSlots = data['carSlots'];
      int bikeSlots = data['bikeSlots'];

      if (vehicleType == "car" && carSlots > 0) {
        carSlots -= 1;
      } else if (vehicleType == "bike" && bikeSlots > 0) {
        bikeSlots -= 1;
      } else {
        print("No slots available for $vehicleType");
        return false;
      }

      await database.updateDocument(
        databaseId: '67dfb51d0010bb70d103',
        collectionId: '67e2f54c003d583b1c45',
        documentId: parkingSpotId,
        data: {'carSlots': carSlots, 'bikeSlots': bikeSlots},
      );

      return true;
    } catch (e) {
      print("Error booking parking slot: $e");
      return false;
    }
  }
}
