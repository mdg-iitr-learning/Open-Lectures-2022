import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefix;
  final String? Function(String?)? validator;
  final IconButton? suffix;
  final int? maxlines;
  final bool isHidden;
  final String? initialValue;
  final bool? enabled;
  final Function(String?)? onChanged;
  const CustomTextField({
    this.controller,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.isHidden = false,
    this.maxlines = 1,
    this.validator,
    this.initialValue,
    this.enabled,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: widget.isHidden,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: widget.maxlines,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      style: const TextStyle(fontSize: 16.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        focusColor: Colors.white,
        labelText: widget.label,
        hintText: widget.hint,
        labelStyle: const TextStyle(
          fontSize: 16.0,
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        prefixIcon: widget.prefix != null ? Icon(widget.prefix) : null,
        suffixIcon: widget.suffix,
      ),
    );
  }
}
