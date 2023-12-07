import 'package:flutter/material.dart';

class AppStyles {
  static InputDecoration inputDecoration({
    required String labelText,
    required String hintText,
    required VoidCallback onTap,
    required IconData sufixIcon,
    required BuildContext context,
  }) {
    final textStyles = Theme.of(context).textTheme;

    return InputDecoration(
      // hint
      hintStyle: textStyles.bodyMedium!.copyWith(fontStyle: FontStyle.italic, color: Colors.grey),
      // regular borders
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      //error borders
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade800, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade800, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      // other properties
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      labelText: labelText,
      hintText: hintText,
      suffixIcon: IconButton(
        onPressed: () => onTap(),
        icon: Icon(sufixIcon),
      ),
    );
  }
}
