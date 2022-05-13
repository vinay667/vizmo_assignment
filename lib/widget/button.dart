

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String text;
  final Color bgColor;
  final Function onPressed;
  CustomButton({required this.text,required this.bgColor,required this.onPressed});
  @override
  Widget build(BuildContext context) {
   return Container(
     height: 43.0,
     decoration: BoxDecoration(
       boxShadow: <BoxShadow>[
         BoxShadow(
           color: Colors.blue.withOpacity(0.1),
           blurRadius: 1,
           offset: const Offset(10, 10),
         ),
       ],
     ),
     child: ElevatedButton(
       child: Text(text),
       onPressed: () {
         onPressed();
       },
       style: ElevatedButton.styleFrom(
           primary: bgColor,
           padding: const EdgeInsets.symmetric(horizontal: 22),
           textStyle: const TextStyle(
               fontSize: 14,
               fontWeight: FontWeight.bold)),
     ),
   );
  }

}