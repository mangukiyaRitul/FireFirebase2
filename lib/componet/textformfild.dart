import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFieldFireFlutter extends StatelessWidget {
  final String? lable;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon, suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  const MyTextFormFieldFireFlutter({
    super.key,
    this.lable,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder({double? width, Color? color}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: color ?? Colors.grey,
            width: width ?? 0.85,
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              '$lable',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.5,
              ),
            ),
          ),
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            // fillColor: Colors.brown.withOpacity(0.095),
            // filled: true,
            counterText: "",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconColor: Colors.brown,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.orangeAccent.shade100,
                width: 2,
              ),
            ),
            focusedBorder: outlineInputBorder(
              color: Colors.orangeAccent.shade400,
              width: 2.0,
            ),
            enabledBorder: outlineInputBorder(
              color: Colors.orangeAccent.shade400,
            ),
            disabledBorder: outlineInputBorder(),
            errorBorder: outlineInputBorder(
              color: Colors.redAccent.shade400,
              width: 2,
            ),
            focusedErrorBorder: outlineInputBorder(
              color: Colors.redAccent.shade700,
              width: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}