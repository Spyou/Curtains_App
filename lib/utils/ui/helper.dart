import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), // Adjust duration as needed
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

