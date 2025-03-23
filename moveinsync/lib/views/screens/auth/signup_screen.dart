import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/auth_controller.dart';
import 'package:moveinsync/views/components/custom_button.dart';
import 'package:moveinsync/views/components/custom_text_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController =
      Get.find<AuthController>(); // GetX Controller

  bool _obscureText = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

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

    authController.signUp(name, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Logo
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4361EE),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.car_rental_outlined,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'MoveInSync',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF121212),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34.h),
              // Title
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF121212),
                  height: 1.1,
                ),
              ),
              SizedBox(height: 16.h),
              // Subtitle
              Text(
                'Enter your details to sign up',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 38.h),

              // Name field
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter your full name',
                label: 'Full Name',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 24.h),

              // Email field
              CustomTextField(
                controller: _emailController,
                hintText: 'Enter your email',
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),

              // Password field
              CustomTextField(
                controller: _passwordController,
                hintText: 'Enter your password',
                label: 'Password',
                obscureText: _obscureText,
                toggleObscureText: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              SizedBox(height: 16.h),

              // Sign Up button
              Obx(
                () => CustomButton(
                  text:
                      authController.isLoading.value
                          ? 'Signing Up...'
                          : 'Sign Up',
                  onPressed:(){
                    if(!authController.isLoading.value) {
                      _signUp();
                    }
                  }
                ),
              ),
              SizedBox(height: 32.h),

              // Login text
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4361EE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
