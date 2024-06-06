import 'package:flutter/material.dart';

final searchBarDecoration = InputDecoration(
    labelStyle: const TextStyle(fontSize: 25, fontFamily: "Roboto"),
    contentPadding: const EdgeInsets.only(bottom: 10, top: 5),
    hintText: 'Enter keyword',
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25)
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25)
    )
);

class HighlightText extends StatelessWidget {
  const HighlightText({Key? key,  this.text, String? keyword}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(text: text));
  }
}
