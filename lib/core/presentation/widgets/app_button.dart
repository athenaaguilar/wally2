import 'package:flutter/material.dart';
import 'package:wally2/core/presentation/widgets/app_loading_indicator.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.all(16.0)),
        backgroundColor:
            MaterialStatePropertyAll(isEnabled ? Colors.blueGrey : Colors.grey),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
      child: isLoading
          ? const AppLoadingIndicator(color: Colors.white)
          : Text(title),
    );
  }
}
