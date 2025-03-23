import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/auth_controller.dart';
import 'package:moveinsync/data/controller/ride_controller.dart';
import 'package:moveinsync/data/controller/ride_history_controller.dart';
import 'package:moveinsync/routes/app_routes.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load(fileName: ".env");
   Get.put(AuthController()); 
Get.put(RideController());
Get.put(RideHistoryController());

    
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          getPages: AppRoutes.routes,
      
          home: child,
        );
      },
     
    );
    
  }
}