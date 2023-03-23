import 'package:donation_flutter/core/get_instances.dart';
import 'package:flutter/cupertino.dart';

import '../models/settings_model.dart';

class PaymentProvider extends ChangeNotifier {
  double amount = 0;
  String clientSecret = "";
  SettingsModel settings = SettingsModel.getSettings();

  //stripe info
  //final String _stripeKey = "sk_test_bXrc5J6iSZu9DEP027r8kqsA";
  //final String _stripeAccount = "acct_1GaC9uHfo422lFkq";
  final int _businessId = 1;
  final String _businessType = "mosque";
  final String _readerId = "tmr_E3TOwMoUvZN0BF";

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

  Future<String?> payNow() async {
    setLoading(true);

    //Create a payment intent
    var result = await GetInstance.dataSource.post(
      "v1/stripe/terminal/create_payment_intent",
      body: {
        "businessId": _businessId,
        "businessType": _businessType,
        "amount": (amount * 100).toInt(),
        "description": "dontation at ${settings.name}"
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
        "businessId": _businessId,
        "businessType": _businessType,
        "paymentIntent": paymentIntentId,
        "readerId": _readerId
      },
    );

    var reader = result["status"] == true ? result["reader"] : null;

    if (reader == null) {
      setLoading(false);
      debugPrint(result);
      return null;
    }

    var completed = false;
    var counter = 0;
    while (!completed && counter++ < 25) {
      await Future.delayed(const Duration(seconds: 3));
      result = await GetInstance.dataSource.post(
        "v1/stripe/terminal/process_payment_intent",
        body: {
          "businessId": _businessId,
          "businessType": _businessType,
          "paymentIntentId": paymentIntentId
        },
      );

      var paymentIntent =
          result["status"] == true ? result["paymentIntent"] : null;

      if (paymentIntent == null) {
        setLoading(false);
        debugPrint(result);
        return null;
      }

      if (paymentIntent["status"] == "canceled" ||
          paymentIntent["status"] == "succeeded") {
        completed = true;
        setLoading(false);
        return paymentIntent["status"];
      }
    }

    setLoading(false);

    return null;
  }
}
