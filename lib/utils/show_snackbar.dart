import 'package:flutter/material.dart';

/// Displays a floating error snackbar at the bottom of the screen displaying a
/// message.
void showSnackbar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Center(child: Text(message)),
        backgroundColor: Theme.of(context).colorScheme.error,
        width: 350.0,
      ),
    );
}
