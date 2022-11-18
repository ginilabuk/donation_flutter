import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:donation_flutter/providers/payment_provider.dart';

List<SingleChildWidget> registeredProviders = [
  // Theme
  ChangeNotifierProvider(create: ((context) => PaymentProvider())),
];
