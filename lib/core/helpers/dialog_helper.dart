import 'package:flutter/material.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

class DialogHelper {
  static showDefaultCustomError({required String message, required String title}) {
    final BuildContext context = rootNavigatorKey.currentContext!;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
