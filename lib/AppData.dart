import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppData {
  static Row row1(String text1, String hintText,
      TextEditingController controller, ValueChanged<String>? onChanged) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SizedBox(
        width: 100,
        child: Text(
          text1,
          maxLines: 2,
          style: TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      Text(":"),
      SizedBox(
        width: 100,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          onChanged: onChanged,
          style: TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }
}
