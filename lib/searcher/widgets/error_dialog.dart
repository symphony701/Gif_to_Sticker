import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ],
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/error.webp',
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Oh no! Something went wrong. Please try with lighter GIFs and check if WhatsApp is installed',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
