import 'package:donation_flutter/views/widgets/payments/payment_process_popup_widget.dart';
import 'package:flutter/material.dart';

class Popups {
  static Future settingsPassword(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _passwordController = TextEditingController();

        return AlertDialog(
          title: Text('Enter Password'),
          content: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop(_passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }

  // Error popup
  static Future paymentStatus(
    BuildContext context, {
    required String readerId,
    required String paymentIntent,
    String? stripeAccount,
    required String stripeKey,
  }) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: Padding(
            padding: EdgeInsets.all(5),
            child: PaymentProcessPopupWidget(
              paymentIntent: paymentIntent,
              readerId: readerId,
              stripeAccount: stripeAccount,
              stripeKey: stripeKey,
            ),
          ),
        );
      },
    );
  }
}
