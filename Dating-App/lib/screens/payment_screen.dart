import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/widgets/default_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  TextEditingController _controller = TextEditingController();

  late AppLocalizations _i18n;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text="100";
  }

  @override
  Widget build(BuildContext context) {

    _i18n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(

        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: Colors.white
        ),
        centerTitle: true,
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Payment'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.maxFinite,
              child: DefaultButton(
                  child: Text(_i18n.translate("CONTINUE"),
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),

                  //
                  //
                  onPressed: () async {
                    Razorpay razorpay = Razorpay();

                    var options = {
                      'key': 'rzp_live_ILgsfZCZoFIKMb',
                      'amount':
                          int.parse(_controller.text.trim()) * 100, //in paise.
                      'name': 'Datting App.',
                      'description': 'Fine T-Shirt',
                      'timeout': 60, // in seconds
                      'prefill': {
                        'contact': '7389681128',
                        'email': 'gaurav.kumar@example.com'
                      }
                    };

                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                        handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        handleExternalWalletSelected);
                    razorpay.open(options);
                  }
                  //
                //

                  ),

              //
            ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */

    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
