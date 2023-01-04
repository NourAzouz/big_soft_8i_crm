import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressAction;
  final String buttonText;
  final bool isBusy;

  const CustomButton({
    Key? key,
    required this.onPressAction,
    required this.buttonText,
    this.isBusy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return Colors.blue;
            return null; // Defer to the widget's default.
          }),
        ),
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: Colors.blue,*/
        child: isBusy
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                buttonText.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
        onPressed: onPressAction,
      ),
    );
  }
}
