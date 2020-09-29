import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormField extends StatelessWidget {
  final bool autovalidate;
  final TextEditingController controller;
  final String labelText;
  final String counterText;
  final IconData icon;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool obscureText;
  final Function(String) validator;
  // final Function onPressed;

  const CustomFormField(
      {@required this.controller,
      @required this.labelText,
      this.counterText,
      @required this.icon,
      this.autovalidate = false,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: this.obscureText,
      // key: _formKey,
      keyboardType: TextInputType.emailAddress,
      autovalidate: autovalidate,
      validator: this.validator,
      decoration: InputDecoration(
        labelText: this.labelText,
        icon: Icon(this.icon),
        prefixIcon: this.prefixIcon,
        suffixIcon: this.suffixIcon,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        counterText: this.counterText,
      ),
      onChanged: (value) => null,
      onSaved: (value) => this.controller.text = value,
      style: GoogleFonts.exo2(
          fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.normal),
    );
  }
}
