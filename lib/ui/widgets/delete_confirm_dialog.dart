import 'package:flutter/material.dart';

import '../colors.dart';

class ConfirmDismissDialog {
  static Future<bool> show(BuildContext context) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Remove this?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey.shade100,
          content: const Text(
            "The item will be deleted and the action cannot be undone.",
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: primary,
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Confirm",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
