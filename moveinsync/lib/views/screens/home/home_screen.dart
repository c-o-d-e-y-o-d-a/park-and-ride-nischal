import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, ${authController.user.value?.name ?? ''}!"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: authController.logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
