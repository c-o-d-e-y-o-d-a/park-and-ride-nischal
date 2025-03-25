import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  final Function onPaymentSuccess;
  
  final double amount;

   PaymentScreen({super.key, required this.amount, required this.onPaymentSuccess});
   final PaymentController paymentController = Get.put(
    PaymentController(
      onPaymentSuccess: () {
        Get.snackbar(
          "Payment Success",
          "Payment was successful!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          width: 330.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Complete Your Payment",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20.h),

              // Amount Input Field
              // TextField(
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     labelText: 'Enter Amount',
              //     hintText: 'Amount in INR',
              //     prefixIcon: Icon(Icons.money, color: Colors.blue),
              //     filled: true,
              //     fillColor: Colors.grey[100],
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12.r),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              //   onChanged: (value) {
              //     double amount = double.tryParse(value) ?? 0.0;
              //     paymentController.initiatePayment(amount);
              //   },
              // ),
              // SizedBox(height: 25.h),

              // Pay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    paymentController.initiatePayment(
                      amount,
                    ); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Pay ${amount}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
