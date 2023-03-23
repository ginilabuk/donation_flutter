// ignore_for_file: use_build_context_synchronously

import 'package:donation_flutter/core/local_storage_keys.dart';
import 'package:donation_flutter/models/settings_model.dart';
import 'package:donation_flutter/router/route_to.dart';
import 'package:donation_flutter/views/widgets/popups/popups.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation_flutter/providers/payment_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<double> prices = [5, 10, 15, 20, 30, 40, 50, 75, 100];
  TextEditingController _amountController = TextEditingController();
  SettingsModel setting = SettingsModel.getSettings();

  Future<void> paymentResponse(PaymentProvider provider) async {
    if (provider.isLoading) return;

    String? paymentIntent = await provider.payNow();

    if (paymentIntent == "succeeded") {
      // Show popup to confirm payment
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Payment Success",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
            ),
            content: Text(
              "Payment of £${provider.amount.toStringAsFixed(2)} successful",
              //"and payment intent is $paymentIntent",
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        },
      );
    } else {
      // Show popup to confirm payment
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Payment Failed",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
            content: Text(
              "Payment of £${provider.amount.toStringAsFixed(2)} failed",
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PaymentProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Please Donate Generously"),
        actions: [
          IconButton(
            onPressed: () async {
              var password = await Popups.settingsPassword(context);

              bool isValid = LocalStorageKeys.checkSettingsPassword(password);

              if (!isValid) return;

              Navigator.pushNamed(context, RouteTo.settings.name);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Text("${setting.name}"),
                  const SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      // Insert buttons to pay for each price
                      for (double price in prices)
                        Container(
                          width: size.width * 0.47,
                          margin: const EdgeInsets.all(2),
                          child: ElevatedButton(
                            onPressed: () async {
                              _amountController.text = "";
                              setState(() {});

                              provider.setAmount(price);
                              await paymentResponse(provider);
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: provider.amount == price
                                  ? Colors.green
                                  : Colors.white,
                              foregroundColor: provider.amount == price
                                  ? Colors.white
                                  : Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              '£${price.toStringAsFixed(0)}',
                              style: const TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Add input field to input custom amount
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter amount",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        provider.setAmount(double.tryParse(value) ?? 0);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async => paymentResponse(provider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Donate',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),

                  // Copyright
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "© Ginilab Ltd",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            // spinner
            if (provider.isLoading)
              Container(
                width: size.width,
                height: size.height,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: SizedBox(
                    width: size.width * .5,
                    height: size.width * .5,
                    child: const CircularProgressIndicator(
                      color: Colors.purple,
                      strokeWidth: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
