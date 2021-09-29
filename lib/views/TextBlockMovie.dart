import 'package:flutter/material.dart';

Widget TextBoxCustom(String text) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        text.toString(),
        style: TextStyle(color: Colors.deepPurple[200]),
      ));
}
