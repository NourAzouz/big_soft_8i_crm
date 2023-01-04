import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(FToast fToast, String message, BuildContext context) {
  fToast.init(context);
  fToast.removeCustomToast();
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.orangeAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.black87,
        ),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        )
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}
