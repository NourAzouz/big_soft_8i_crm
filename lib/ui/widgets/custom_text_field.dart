import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  // TODO: I Removed all attribut types to avoid errors
  final inputLabel;
  final hintText;
  final controller;
  final validation;
  final onTapAction;
  final onChanged;
  final onFieldSubmitted;
  final readOnly;
  final enabled;
  final filled;
  final suffixText;
  final suffixIcon;
  final style;
  final minLines;
  final maxLines;
  final keyboardType;
  final helperText;
  final autovalidateMode;
  final inputFormatters;

  const CustomTextField({
    Key? key,
    this.inputLabel,
    this.controller,
    this.validation,
    this.hintText,
    this.keyboardType,
    this.style,
    this.readOnly = false,
    this.enabled = true,
    this.filled = false,
    this.onChanged,
    this.onTapAction,
    this.suffixIcon,
    this.minLines,
    this.maxLines,
    this.suffixText,
    this.helperText,
    this.autovalidateMode,
    this.inputFormatters,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      style: TextStyle(color: Colors.black),
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: Colors.purple,
      decoration: InputDecoration(
        suffixText: suffixText ?? null,
        fillColor: Colors.white,
        filled: filled,
        hintText: hintText ?? null,
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: const TextStyle(
          color: Colors.red,
        ),
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
        suffixIcon: suffixIcon,
        labelText: inputLabel!,
        labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: filled ? Colors.purple[700] : Colors.purple[600],
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: filled
                ? Color.fromARGB(255, 243, 33, 233)
                : Color.fromARGB(255, 177, 33, 243),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: filled ? Colors.purple : Colors.purple),
          borderRadius: const BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
      ),
      validator: validation,
      onTap: onTapAction,
    );
  }
}
