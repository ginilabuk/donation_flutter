import 'package:donation_flutter/core/get_instances.dart';
import 'package:flutter/cupertino.dart';

class PaymentProvider extends ChangeNotifier {
  double amount = 0;
  String clientSecret = "";

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
    // var result = await GetInstance.dataSource.post(
    //   "v1/stripe/terminal/create_payment_intent",
    //   body: {
    //     "stripeToken": "sk_test_bXrc5J6iSZu9DEP027r8kqsA",
    //     "stripeAccount": "acct_1JhW9T2eliNoeKob",
    //     "location": "tml_E2mjEg76Y2Y0n4",
    //     "amount": x * 100,
    //   },
    // );

    var result = await GetInstance.dataSource.post(
      "v1/stripe/terminal/create_payment_intent",
      body: {
        "stripeToken": "sk_test_bXrc5J6iSZu9DEP027r8kqsA",
        "stripeAccount": "acct_1JhW9T2eliNoeKob",
        "location": "tml_E2mjEg76Y2Y0n4",
        "amount": amount * 100,
      },
    );

    // await Future.delayed(Duration(seconds: 1));

    // print(result);

    setLoading(false);

    if (result != null &&
        result["status"] == true &&
        result["client_secret"] != null) {
      return result["client_secret"];
    } else {
      return null;
    }
  }
}
