import 'package:donation_flutter/core/get_instances.dart';
import 'package:flutter/cupertino.dart';

class PaymentProvider extends ChangeNotifier {
  double amount = 0;
  String clientSecret = "";

  //stripe info
  final String _stripeKey = "sk_test_bXrc5J6iSZu9DEP027r8kqsA";
  final String _stripeAccount = "acct_1GaC9uHfo422lFkq";
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
        "stripeToken": _stripeKey,
        "stripeAccount": _stripeAccount,
        "applicationFee": ((amount / 100) * 100).toInt(),
        "amount": (amount * 100).toInt(),
      },
    );

    var paymentIntentId =
        result["status"] == true ? result["payment_intent_id"] : null;

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
        "stripeToken": "sk_test_bXrc5J6iSZu9DEP027r8kqsA",
        "paymentIntent": paymentIntentId,
        "readerId": _readerId,
        "amount": (amount * 100).toInt(),
        "description": "Donation"
      },
    );

    var readerAction = result["status"] == true ? result["action"] : null;

    if (readerAction == null) {
      setLoading(false);
      debugPrint(result);
      return null;
    }

    await Future.delayed(const Duration(milliseconds: 30));

    setLoading(false);

    //Check reader status
    if (readerAction == 'succeeded') {
      return readerAction;
    }

    // print(result);

    return null;
  }
}
