import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/shared/styles/color.dart';




ThemeData lightTheme= ThemeData (

  scaffoldBackgroundColor: Colors.white,
  primarySwatch:Colors.blueGrey ,

  appBarTheme:  AppBarTheme(

    titleSpacing: 20,
    titleTextStyle:const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: defaultColor,
    elevation: 0,
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: defaultColor,
      statusBarIconBrightness: Brightness.dark,

    ),
    iconTheme: const IconThemeData(
        color: Colors.black
    ),
  ),

  fontFamily: 'Jannah',


);




