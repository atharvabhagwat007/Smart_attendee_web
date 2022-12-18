import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton({super.key, required this.title, this.isEditbutton});

  String title;
  bool? isEditbutton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isEditbutton ?? true ? 200 : 100,
      height: isEditbutton ?? true ? 50 : 30,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          border: Border.all()),
      child: Padding(
        padding:
            isEditbutton ?? true ? const EdgeInsets.all(10.0) : EdgeInsets.zero,
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: isEditbutton ?? true ? 18 : 14,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        )),
      ),
    );
  }
}
