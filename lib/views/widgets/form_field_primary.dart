import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FormFieldPrimary extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final String? label;
  final void Function(String value)? onChanged;

  const FormFieldPrimary({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        style: const TextStyle(
          fontSize: 35,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          label: label != null ? Text(label!) : null,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
