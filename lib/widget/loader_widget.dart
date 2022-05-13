

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LoaderWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return  CircularProgressIndicator(
     valueColor: AlwaysStoppedAnimation<Color>(MyColor.appTheme),
   );
  }

}