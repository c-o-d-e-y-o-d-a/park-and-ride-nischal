import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/auth_controller.dart';
import 'package:moveinsync/views/components/custom_button.dart';
import 'package:moveinsync/views/components/custom_text_feild.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load current user data
    if (authController.user.value != null) {
      _nameController.text = authController.user.value!.name ;
      _emailController.text = authController.user.value!.email;
      _phoneController.text = authController.user.value!.prefs.data['phone'] ?? "";
      _usernameController.text =
          authController.user.value!.prefs.data["username"] ?? "";
    }
  }

  void _saveProfile() {
    String name = _nameController.text.trim();
    String username = _usernameController.text.trim();
    String phone = _phoneController.text.trim();

    if (name.isEmpty || username.isEmpty || phone.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    authController.updateProfile(name, username, phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    child: Icon(Icons.person, size: 50.sp, color: Colors.blue),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, size: 16.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),

            // Name Field
            CustomTextField(
              controller: _nameController,
              hintText: 'Enter your full name',
              label: 'Full Name',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 20.h),

            // Username Field
            CustomTextField(
              controller: _usernameController,
              hintText: 'Enter your username',
              label: 'Username',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20.h),

            // Email Field (Non-Editable)
            CustomTextField(
              controller: _emailController,
              hintText: 'Your email',
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),

            // Phone Field
            CustomTextField(
              controller: _phoneController,
              hintText: 'Enter your phone number',
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 30.h),

            // Save Button
            Obx(
              () => CustomButton(
                text:
                    authController.isLoading.value
                        ? 'Saving...'
                        : 'Save Profile',
                onPressed: (){
                  if(!authController.isLoading.value) {
                    _saveProfile();
                  }
                }
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
