import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  const CustomTextInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        labelText: labelText,
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        labelStyle: GoogleFonts.inter(color: Color(0xFF4c0b04)) ,
        errorStyle: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
