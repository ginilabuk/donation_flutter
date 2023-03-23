import 'package:donation_flutter/core/extensions.dart';
import 'package:flutter/material.dart';

class Parse<T> {
  dynamic value;
  T? defaultValue;

  Parse(this.value, [this.defaultValue]);

  int? _parseInt() {
    try {
      var v = int.tryParse(value.toString());

      return v;
    } catch (e) {
      return null;
    }
  }

  double? _parseDouble() {
    try {
      var v = double.tryParse(value.toString());

      return v;
    } catch (e) {
      return null;
    }
  }

  // Parse datetime
  DateTime? _parseDateTime() {
    try {
      var v = DateTime.tryParse(value.toString());

      return v;
    } catch (e) {
      return null;
    }
  }

  Color? _parseColor() {
    try {
      var v = value.toString();

      bool isHex = v.contains("#");

      if (isHex) {
        return v.toColor();
      } else {
        bool isBootstrapColor = [
          "light",
          "dark",
          "primary",
          "info",
          "warning",
          "danger",
          "alert",
          "system",
          "success",
        ].contains(v);

        if (isBootstrapColor) {
          switch (v) {
            case "light":
              return const Color(0xffffffff);
            case "dark":
              return Colors.black;
            case "primary":
              return const Color(0xff4a89dc);
            case "info":
              return const Color(0xff3bafda);
            case "warning":
              return const Color(0xfff6bb42);
            case "danger":
              return const Color(0xffe9573f);
            case "alert":
              return const Color(0xff967adc);
            case "system":
              return const Color(0xff37bc9b);
            case "success":
              return const Color(0xff70ca63);
            default:
              return null;
          }
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  bool? _parseBoolean() {
    try {
      return value == true ||
          value == 1 ||
          value == "1" ||
          value == "true" ||
          value == "yes" ||
          value == "True";
    } catch (e) {
      return false;
    }
  }

  parse() {
    try {
      if (value == null) {
        return defaultValue;
      }

      // Parse integer
      if (T == int) {
        return _parseInt() ?? defaultValue;
      }

      // Parse color
      if (T == Color) {
        return _parseColor() ?? defaultValue;
      }

      // Parse double
      if (T == double) {
        return _parseDouble() ?? defaultValue;
      }

      // Parse boolean
      if (T == bool) {
        return _parseBoolean() ?? defaultValue;
      }

      // Parse datetime
      if (T == DateTime) {
        return _parseDateTime() ?? defaultValue;
      }
    } catch (e) {
      return null;
    }
  }
}
