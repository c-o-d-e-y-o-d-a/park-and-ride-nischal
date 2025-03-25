import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moveinsync/data/controller/auth_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  AuthController authController = Get.find<AuthController>();
  late Razorpay _razorpay;
  final Function? onPaymentSuccess;

  PaymentController({required this.onPaymentSuccess});

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (){onPaymentSuccess!();});
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void initiatePayment(double amount) {
    var options = {
      'key': dotenv.env['RAZORPAY_KEY_ID'],  
      'amount': (amount * 100).toInt(), 
      'name': 'MoveInSync',
      'description': 'Ride Payment',
      'prefill': {'contact': authController.user.value!.email, 'email': authController.user.value!.email,
      },
      'theme': {'color': '#4361EE'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Payment Failed",
      "Error: ${response.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      "External Wallet Selected",
      "Wallet: ${response.walletName}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
