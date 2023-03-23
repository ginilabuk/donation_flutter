import 'dart:convert';

import 'package:donation_flutter/core/parse.dart';

class IntentInformationModel {
  DateTime? createAt;
  String? reference;
  String? authCode;
  String? cardNumber;
  String? cardType;
  int stripeAmount;
  String? contactType;
  String? currency;

  IntentInformationModel({
    this.createAt,
    this.reference,
    this.authCode,
    this.cardNumber,
    this.cardType,
    this.stripeAmount = 0,
    this.contactType,
    this.currency,
  });

  String encodeToString() => jsonEncode({
        "createAt": createAt?.toIso8601String(),
        "reference": reference,
        "authCode": authCode,
        "cardNumber": cardNumber,
        "cardType": cardType,
        "stripeAmount": stripeAmount,
        "contactType": contactType,
        "currency": currency,
      });

  static IntentInformationModel? fromEncodedString(String encodedString) {
    Map<String, dynamic>? data;
    try {
      data = jsonDecode(encodedString);
      if (data == null) {
        return null;
      }

      IntentInformationModel object = IntentInformationModel(
        createAt: Parse<DateTime>(data["createAt"]).parse(),
        reference: data["reference"],
        authCode: data["authCode"],
        cardNumber: data["cardNumber"],
        cardType: data["cardType"],
        stripeAmount: Parse<int>(data["stripeAmount"]).parse(),
        contactType: data["contactType"],
        currency: data["currency"],
      );

      return object;
    } catch (e) {
      return null;
    }
  }
}
