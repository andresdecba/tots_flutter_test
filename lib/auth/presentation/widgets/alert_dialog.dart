import 'package:flutter/material.dart';

void loginErrorDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error al iniciar sesión'),
        content: const Text('Usuario y/o contraseña incorrectos'),
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
