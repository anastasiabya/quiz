import 'package:flutter/material.dart';

void showError(BuildContext context, Exception error) {
  ScaffoldMessenger.of(context).showSnackBar(
    _ErrorSnackbar(
      text: error.toString(),
    ),
  );
}

class _ErrorSnackbar extends SnackBar {
  _ErrorSnackbar({Key? key, required String text})
      : super(
          key: key,
          content: Text(text),
        );
}
