// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names

class WidgetClass {
  Widget customButton(String text, onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget customRichText(
      BuildContext context, String textOne, String textTwo, ontap) {
    return GestureDetector(
      onTap: ontap,
      child: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          text: textOne,
          style: const TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
              text: textTwo,
              style: const TextStyle(fontSize: 20, color: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  Widget textFormField(controller, String labelText, String returnText, keyboardType) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return returnText;
        }
        return null;
      },
    );
  }
}
