import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/auth_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Drawer(
      width: 300.w,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40.sp, color: Colors.blue),
                ),
                SizedBox(height: 10.h),
                Text(
                  authController.user.value!.name ,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                 authController.user.value!.email,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Drawer Items
          _drawerItem(
            icon: Icons.home,
            text: "Home",
            onTap: () => Get.toNamed('/home'),
          ),
          _drawerItem(
            icon: Icons.car_rental,
            text: "My Rides",
            onTap: () => Get.toNamed('/rides'),
          ),
          _drawerItem(
            icon: Icons.local_parking,
            text: "Parking Slots",
            onTap: () => Get.toNamed('/parking'),
          ),
         
           _drawerItem(
            icon: Icons.note,
            text: "Terms and Conditions",
            onTap: () => Get.toNamed('/soon'),
          ),
           _drawerItem(
            icon: Icons.settings,
            text: "Settings",
            onTap: () => Get.toNamed('/soon'),
          ),


          const Spacer(),

        
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
            child: ElevatedButton(
              onPressed: () {
               authController.logout(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.white, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    "Logout",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Drawer Item Widget
  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 24.sp),
        title: Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        hoverColor: Colors.blue.withOpacity(0.1),
      ),
    );
  }
}
