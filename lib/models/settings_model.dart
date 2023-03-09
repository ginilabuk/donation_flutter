import 'dart:convert';

import 'package:donation_flutter/core/get_instances.dart';

class SettingsModel {
  String? name;
  String? address;
  String? phone;
  String? stripeAPIKey;
  String? stripeAccountId;

  SettingsModel({
    this.name,
    this.address,
    this.phone,
    this.stripeAPIKey,
    this.stripeAccountId,
  });

  static String prefSettingsKey = "settings";

  Future<bool> save() async {
    return await GetInstance.localStorage
        .setString(prefSettingsKey, jsonEncode(toJson()));
  }

  static SettingsModel getSettings() {
    var data = GetInstance.localStorage.getString(prefSettingsKey);

    if (data == null) return SettingsModel();

    return fromJson(jsonDecode(data));
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone": phone,
        "stripeAPIKey": stripeAPIKey,
        "stripeAccountId": stripeAccountId,
      };

  static SettingsModel fromJson(Map<String, dynamic> map) => SettingsModel(
        name: map['name'],
        address: map['address'],
        phone: map['phone'],
        stripeAPIKey: map['stripeAPIKey'],
        stripeAccountId: map['stripeAccountId'],
      );
}
