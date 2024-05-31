import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentIntegration extends StatefulWidget {
  const PaymentIntegration({super.key});

  @override
  State<PaymentIntegration> createState() => _PaymentIntegrationState();
}

class _PaymentIntegrationState extends State<PaymentIntegration> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'dummy', // Replace with your actual key
      'amount': 100, // Amount in paise
      'name': 'Quickshield',
      'description': '1-time fix',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    debugPrint("Payment Success: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    debugPrint("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    debugPrint("External Wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razorpay Payment Gateway"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: openCheckout, child: Text('Open'))
          ],
        ),
      ),
    );
  }
}
