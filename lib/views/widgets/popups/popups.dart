import 'package:flutter/material.dart';

class Popups {
  static Future settingsPassword(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _passwordController = TextEditingController();

        return AlertDialog(
          title: Text('Enter Password'),
          content: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop(_passwordController.text);
              },
            ),
          ],
        );
      },
    );
  }
}
