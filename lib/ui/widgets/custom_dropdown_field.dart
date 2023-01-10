import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  // TODO: I removed function type for onChangedAction & validator to avoid an error
  final labelText;
  final value;
  final items;
  final onChangedAction;
  final validator;

  const CustomDropdownField({
    Key? key,
    this.labelText,
    this.value,
    this.items,
    this.onChangedAction,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
        labelText: labelText,
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
      value: value,
      items: items,
      onChanged: onChangedAction,
      validator: validator!,
    );
  }
}
