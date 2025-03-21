import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';

class AuthRepository {
  late Client _client;
  late Account _account;

  AuthRepository() {
    _client = Client()
        .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
        .setProject('67dc7e1e0013be3ea090'); // Your project ID

    _account = Account(_client);
  }
Future<void> updateUserProfile(
    String name,
    String username,
    String phone,
  ) async {
    try {
      await _account.updatePrefs( prefs: {
        'name': name,
        'username': username,
        'phone': phone,
      });

      await _account.updateName(name: name);
    } catch (e) {
      throw Exception("Profile update failed: $e");
    }
  }

  /// Create a new user account
  Future<User?> signUp(String name, String email, String password) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return user;
    } catch (e) {
      Get.snackbar('Error', 'Signup failed: $e');
      return null;
    }
  }

  /// Login user with email & password
  Future<Session?> login(String email, String password) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session;
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
      return null;
    }
  }

  /// Get current logged-in user
  Future<User?> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user;
    } catch (e) {
      return null; // Not logged in
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: $e');
    }
  }
}
