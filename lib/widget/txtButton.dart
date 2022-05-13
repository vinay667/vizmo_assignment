

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomTextButton extends StatelessWidget{
  final String text;
  final Function onPressed;
  CustomTextButton({required this.text,required this.onPressed});
  @override
  Widget build(BuildContext context) {
   return InkWell(
     child: Text(text,style: TextStyle(
         fontSize: 17,
         color: MyColor.primaryPurple,
         fontWeight: FontWeight.bold),),
     onTap: () {
       onPressed();
     },
   );
  }

}