import 'package:donation_flutter/core/get_instances.dart';
import 'package:donation_flutter/enums/payment_status.dart';
import 'package:donation_flutter/views/widgets/popups/popups.dart';
import 'package:flutter/cupertino.dart';

import '../models/settings_model.dart';

class PaymentProvider extends ChangeNotifier {
  double amount = 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Set loading
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setAmount(double a) {
    amount = a;

    notifyListeners();
  }

  Future<String?> payNow(BuildContext context) async {
    setLoading(true);
    try {
      SettingsModel settings = SettingsModel.getSettings();

      //stripe info
      String stripeKey = "sk_live_0EqQ5sASlf4mrK8ywjoyL4vL";
      String? stripeAccount = settings.stripeAccountId;
      //final int _businessId = 1;
      //final String _businessType = "mosque";
      final String? readerId = settings.readerId;

      //Create a payment intent
      var result = await GetInstance.dataSource.post(
        "v1/stripe/terminal/create_payment_intent",
        body: {
          "businessId": "",
          "businessType": "",
          "stripeToken": stripeKey,
          "stripeAccount": stripeAccount,
          "applicationFee": amount.ceil().toInt(),
          "amount": (amount * 100).toInt(),
          "description":
              "${settings.name} donation".characters.take(22).toString(),
          "paymentIntentId": ""
        },
      );

      var paymentIntentId =
          result?["status"] == true ? result["payment_intent_id"] : null;

      if (paymentIntentId == null) {
        setLoading(false);
        debugPrint(result);
        return null;
      }

      await Future.delayed(const Duration(microseconds: 30));

      //Process payment
      result = await GetInstance.dataSource.post(
        "v1/stripe/terminal/process_payment_intent",
        body: {
          "businessId": "",
          "businessType": "",
          "stripeToken": stripeKey,
          "stripeAccount": stripeAccount,
          "paymentIntent": paymentIntentId,
          "readerId": readerId
        },
      );

      var reader = result?["status"] == true ? result["reader"] : null;

      if (reader == null) {
        setLoading(false);
        debugPrint(result);
        return null;
      }

      var paymentResult = await Popups.paymentStatus(
        context,
        paymentIntent: paymentIntentId,
        readerId: readerId!,
        stripeAccount: stripeAccount,
        stripeKey: stripeKey,
      );

      if (paymentResult['status'] == PaymentStatus.succeeded) {
        return PaymentStatus.succeeded.value;
      }
      return null;
    } catch (e) {
      print(e);
    } finally {
      setLoading(false);
    }
  }
}
