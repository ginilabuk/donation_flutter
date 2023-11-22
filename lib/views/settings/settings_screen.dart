// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:donation_flutter/models/settings_model.dart';
import 'package:donation_flutter/views/widgets/form_field_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsModel? settings;

  @override
  void initState() {
    super.initState();
    settings = SettingsModel.getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FormFieldPrimary(
              label: "Mosque Name",
              initialValue: settings?.name,
              onChanged: (value) {
                settings?.name = value;
              },
            ),
            FormFieldPrimary(
              label: "Address",
              initialValue: settings?.address,
              onChanged: (value) {
                settings?.address = value;
              },
            ),
            FormFieldPrimary(
              label: "Phone",
              initialValue: settings?.phone,
              onChanged: (value) {
                settings?.phone = value;
              },
            ),
            // FormFieldPrimary(
            //   label: "Stripe API Key",
            //   initialValue: settings?.stripeAPIKey,
            //   onChanged: (value) {
            //     settings?.stripeAPIKey = value;
            //   },
            // ),
            FormFieldPrimary(
              label: "Mosque Id",
              initialValue: settings?.mosqueId,
              onChanged: (value) {
                settings?.mosqueId = value;
              },
            ),
            FormFieldPrimary(
              label: "Stripe Account Id",
              initialValue: settings?.stripeAccountId,
              onChanged: (value) {
                settings?.stripeAccountId = value;
              },
            ),
            FormFieldPrimary(
              label: "Reader ID",
              initialValue: settings?.readerId,
              onChanged: (value) {
                settings?.readerId = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 50),
              child: ElevatedButton(
                onPressed: () async {
                  var isSaved = await settings!.save();

                  if (isSaved) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).clearSnackBars();

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Settings not saved")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 25,
                    ),
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
