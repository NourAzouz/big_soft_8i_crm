import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final bool? isExtended;
  final VoidCallback? onPress;

  const CustomFloatingButton({this.isExtended, this.onPress});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(isExtended! ? 24 : 28),
          right: Radius.circular(isExtended! ? 24 : 28),
        ),
      ),
      height: isExtended! ? 48 : 56,
      width: isExtended! ? 120 : 56,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith<double?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return 6;
            return null;
          }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(isExtended! ? 24 : 28),
                right: Radius.circular(isExtended! ? 24 : 28),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return Colors.blue;
            return null; // Defer to the widget's default.
          }),
        ),
        /*elevation: 6,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isExtended! ? 24 : 28),
            right: Radius.circular(isExtended! ? 24 : 28),
          ),
        ),*/
        onPressed: onPress,
        child: isExtended!
            ? FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 3,
                    right: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Nouveau",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const Icon(
                Icons.add,
                color: Colors.white,
              ),
      ),
    );
  }
}
