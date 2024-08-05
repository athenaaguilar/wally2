import 'package:flutter/material.dart';

void showAppSnackbar(
  BuildContext context, {
  required String label,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black.withOpacity(0.4),
    ),
  );
}
