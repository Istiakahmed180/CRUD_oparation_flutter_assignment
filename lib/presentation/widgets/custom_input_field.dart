import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final dynamic controllerName;
  final String hintText;
  final double? hintTextSize;
  final dynamic inputType;
  final String? Function(String?)? validator;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool obscureText;
  final double? enabledBorderRadius;
  final double? focusBorderRadius;
  final Color? enabledBorderSideColor;
  final Color? focusBorderSideColor;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final Color? fillColor;
  final bool? boxShadow;

  const CustomInputField(
      {super.key,
      required this.controllerName,
      required this.hintText,
      required this.inputType,
      this.hintTextSize,
      this.validator,
      this.prefixWidget,
      this.suffixWidget,
      this.obscureText = false,
      this.enabledBorderRadius,
      this.focusBorderRadius,
      this.enabledBorderSideColor = Colors.grey,
      this.focusBorderSideColor = Colors.grey,
      this.contentPaddingVertical,
      this.contentPaddingHorizontal,
      this.fillColor,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey.withOpacity(0.2),
      autovalidateMode: AutovalidateMode.disabled,
      style: const TextStyle(fontSize: 12),
      controller: controllerName,
      validator: validator,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(enabledBorderRadius ?? 4),
          borderSide: BorderSide(color: Colors.red.withOpacity(0.2), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(enabledBorderRadius ?? 4),
          borderSide: BorderSide(color: Colors.red.withOpacity(0.2), width: 1),
        ),
        prefix: prefixWidget,
        suffixIcon: suffixWidget,
        contentPadding: EdgeInsets.symmetric(
            vertical: contentPaddingVertical ?? 5,
            horizontal: contentPaddingHorizontal ?? 14),
        fillColor: fillColor ?? Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: hintTextSize ?? 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(enabledBorderRadius ?? 4),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(focusBorderRadius ?? 4),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      obscureText: obscureText,
      keyboardType: inputType,
    );
  }
}
