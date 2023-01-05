import 'package:flutter/material.dart';
import '/core/constants/constants.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final inputLabel;
  final controller;
  final validation;

  const CustomTextFieldPassword({
    Key? key,
    this.inputLabel,
    this.controller,
    this.validation,
  }) : super(key: key);

  @override
  _CustomTextFieldPasswordState createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  var showSuffixIcon = Constants.password == null;
  var _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorColor: Colors.grey,
      obscureText: _obscureText,
      maxLines: 1,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() {
            showSuffixIcon = true;
          });
        }
      },
      decoration: InputDecoration(
        helperText: ' ',
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        suffixIcon: showSuffixIcon
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        labelText: widget.inputLabel!,
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.blue,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
      ),
      validator: widget.validation!,
    );
  }
}
