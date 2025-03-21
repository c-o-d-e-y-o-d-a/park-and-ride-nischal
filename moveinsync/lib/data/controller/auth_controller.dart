import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/models.dart';
import 'package:moveinsync/data/repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    checkAuthState(); 
  }

  /// Sign up new user
  Future<void> signUp(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      User? newUser = await _authRepo.signUp(name, email, password);
      if (newUser != null) {
        user.value = newUser;
        isLoggedIn.value = true;

        Get.snackbar(
          "Success",
          "Account created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );

        Get.offAllNamed('/home'); // Navigate to home screen
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Signup failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }

  /// Login user
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter both email and password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      Session? session = await _authRepo.login(email, password);
      if (session != null) {
        user.value = await _authRepo.getCurrentUser();
        isLoggedIn.value = true;

        Get.snackbar(
          "Success",
          "Login successful!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );

        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Login failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }
  Future<void> updateProfile(String name, String username, String phone) async {
    isLoading.value = true;
    try {
      await _authRepo.updateUserProfile(name, username, phone);
      user.value = await _authRepo.getCurrentUser();

      Get.snackbar(
        "Success",
        "Profile updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Profile update failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }


  /// Check if user is already logged in
  Future<void> checkAuthState() async {
    try {
      User? currentUser = await _authRepo.getCurrentUser();
      if (currentUser != null) {
        user.value = currentUser;
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      } else {
        isLoggedIn.value = false;
        Get.offAllNamed('/login');
      }
    } catch (e) {
      isLoggedIn.value = false;
      Get.offAllNamed('/login');
    }
  }

  /// Logout user
  Future<void> logout() async {
    isLoading.value = true;

    try {
      await _authRepo.logout();
      user.value = null;
      isLoggedIn.value = false;

      Get.snackbar(
        "Success",
        "Logged out successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        "Error",
        "Logout failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }

    isLoading.value = false;
  }
}
