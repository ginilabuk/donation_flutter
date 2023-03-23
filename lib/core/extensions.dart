import 'dart:ui';

extension StringExtension on String {
  String add(String? text) {
    if (text != null) {
      return "$this $text";
    } else {
      return this;
    }
  }

  String toTitleCase() {
    var s = toLowerCase();
    s = s.replaceFirst(s[0], s[0].toUpperCase());
    return s;
  }

  String trimNegativeInt() {
    var v = this;
    if (v.contains("-")) {
      bool isStartWithMinus = v.startsWith("-");

      v = v.replaceAll("-", "");
      v = isStartWithMinus ? "-$v" : v;
    }

    return v;
  }

  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension IntergerExtension on int {
  double get toAmount => this / 100.0;

  DateTime? get toDateTime {
    try {
      int timestampInMilliseconds = this * 1000;
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);

      return dateTime;
    } catch (e) {
      return null;
    }
  }
}
