// ignore_for_file: use_build_context_synchronously

import 'package:donation_flutter/core/extensions.dart';
import 'package:donation_flutter/core/get_instances.dart';
import 'package:donation_flutter/core/parse.dart';
import 'package:donation_flutter/enums/payment_status.dart';
import 'package:donation_flutter/models/intent_information.dart';
import 'package:donation_flutter/models/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentProcessPopupWidget extends StatefulWidget {
  final String readerId;
  final String paymentIntent;
  final String stripeKey;
  final String? stripeAccount;

  const PaymentProcessPopupWidget({
    super.key,
    required this.readerId,
    required this.paymentIntent,
    this.stripeAccount,
    required this.stripeKey,
  });

  @override
  State<PaymentProcessPopupWidget> createState() =>
      _PaymentProcessPopupWidgetState();
}

class _PaymentProcessPopupWidgetState extends State<PaymentProcessPopupWidget> {
  bool isBusy = false;
  String? error;
  String? animatedMessage;
  bool cancelAction = false;
  PaymentStatus? paymentStatus;
  IntentInformationModel? successPaymentInformation;

  Future getPaymentIntent() async {
    try {
      cancelAction = false;
      setState(() {
        error = null;
        paymentStatus = PaymentStatus.inProgress;
        isBusy = true;
        animatedMessage = "Processing";
      });

      int attempt = 0;
      while (attempt < 25 && !cancelAction) {
        if (paymentStatus == PaymentStatus.failed ||
            paymentStatus == PaymentStatus.succeeded) {
          break;
        }

        await Future.delayed(const Duration(seconds: 3));
        paymentStatus = await checkPaymentStatus();

        if (paymentStatus == PaymentStatus.failed ||
            paymentStatus == PaymentStatus.succeeded) {
          break;
        }

        if (paymentStatus == PaymentStatus.unknown) {
          break;
        }

        attempt += 1;
      }

      print("Completed Checking payment status. ${paymentStatus?.name}");
    } catch (e) {
      error = e.toString();
    } finally {
      isBusy = false;

      if (paymentStatus == PaymentStatus.failed ||
          paymentStatus == PaymentStatus.succeeded) {
        Navigator.of(context).pop(
          {"status": paymentStatus},
        );
      }
    }
  }

  Future cancelPayment() async {
    try {
      setState(() {
        error = null;
        animatedMessage = "Please wait";
      });

      SettingsModel settings = SettingsModel.getSettings();

      var result = await GetInstance.dataSource
          .post("v1/stripe/terminal/cancel_payment", body: {
        "businessId": settings.mosqueId ?? "",
        "businessType": "mosque",
        "stripeToken": widget.stripeKey,
        "paymentIntent": widget.paymentIntent,
        "readerId": widget.readerId,
        "stripeAccount": widget.stripeAccount,
      });

      if (result == null) {
        throw "Cannot create payment intent";
      } else {
        paymentStatus = PaymentStatus.cancelled;
      }
    } catch (e) {
      error = e.toString();
    }
  }

  Future checkPaymentStatus() async {
    try {
      setState(() {
        error = null;
        animatedMessage = "Please wait";
      });

      SettingsModel settings = SettingsModel.getSettings();

      await Future.delayed(const Duration(seconds: 3));
      var result = await GetInstance.dataSource.post(
        "v1/stripe/terminal/get_payment_intent",
        body: {
          "businessId": settings.mosqueId ?? "",
          "businessType": "mosque",
          "stripeToken": widget.stripeKey,
          "stripeAccount": widget.stripeAccount,
          "paymentIntentId": widget.paymentIntent
        },
      );

      var paymentIntent =
          result["status"] == true ? result["paymentIntent"] : null;

      if (paymentIntent == null) {
        debugPrint(result);
        return PaymentStatus.unknown;
      }

      if (paymentIntent['status'] == PaymentStatus.cancelled.value) {
        return PaymentStatus.cancelled;
      }
      if (paymentIntent['status'] == PaymentStatus.succeeded.value) {
        return PaymentStatus.succeeded;
      }
    } catch (e) {
      error = e.toString();
      return PaymentStatus.unknown;
    }
  }

  @override
  void initState() {
    super.initState();
    getPaymentIntent();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: [
          Text("Payment processing"),
          const Divider(),
          Container(
            constraints: BoxConstraints(minHeight: 300),
            child: Column(children: [
              if (isBusy)
                SizedBox(
                  width: 250.0,
                  child: Row(
                    children: [
                      if (animatedMessage != null)
                        Text(
                          animatedMessage!,
                        ),
                    ],
                  ),
                ),
              if (!isBusy)
                Text(
                  "The payment is not completed.\nTry again",
                ),
              if (error != null)
                Text(
                  error!,
                ),
            ]),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  autofocus: true,
                  onPressed: isBusy
                      ? null
                      : () async {
                          setState(() => isBusy = true);
                          await checkPaymentStatus();
                          setState(() => isBusy = false);
                          if (paymentStatus == PaymentStatus.cancelled ||
                              paymentStatus == PaymentStatus.succeeded ||
                              paymentStatus == PaymentStatus.failed) {
                            Navigator.of(context).pop(
                              {"status": paymentStatus},
                            );
                          }
                        },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                  ),
                  child: Text(
                    'Try again'.toUpperCase(),
                    style: TextStyle(
                      color: isBusy ? Colors.grey : Colors.green,
                      fontSize: 25,
                    ),
                  )),
              TextButton(
                autofocus: true,
                onPressed: () async {
                  cancelAction = true;
                  setState(() => isBusy = true);
                  await cancelPayment();
                  setState(() => isBusy = false);
                  if (paymentStatus == PaymentStatus.cancelled) {
                    Navigator.of(context).pop(
                      {"status": paymentStatus},
                    );
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: isBusy ? Colors.grey : Colors.green,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
