import 'package:flutter/cupertino.dart';

class TestProvider extends ChangeNotifier {
  double amount = 0;

  void payNow(double x) {
    amount = x;
    notifyListeners();
  }
}
