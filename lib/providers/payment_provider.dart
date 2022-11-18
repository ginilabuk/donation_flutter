import 'package:flutter/cupertino.dart';

class PaymentProvider extends ChangeNotifier {
  double amount = 0;

  void payNow(double x) {
    amount = x;
    notifyListeners();
  }
}
