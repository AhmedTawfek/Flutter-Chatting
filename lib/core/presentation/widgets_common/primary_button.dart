import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:flutter/material.dart';

import '../theming/styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback onPressed; // Callback function for click event

  const PrimaryButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
    required this.onPressed, // Required callback
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isEnabled ? onPressed : null,
        style: TextButton.styleFrom(
            fixedSize: const Size(double.maxFinite, 60),
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor:
                isEnabled ? ColorManager.primary : ColorManager.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(46))),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white, // Spinner color
                ),
              )
            : Text(
                text,
                style:
                    TextStyles.heading5.copyWith(color: ColorManager.onPrimary),
              ));
  }
}
