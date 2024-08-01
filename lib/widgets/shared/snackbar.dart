import 'package:flutter/material.dart';

class BasicSnackBar{

  void showSnackBar(BuildContext context, String message, Color? background, IconData? snackIcon, {Duration? duration}){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(snackIcon, color: Colors.white),
            const SizedBox(width: 8),
            Flexible(child: Text(message, style: const TextStyle(fontSize: 13)))
          ]  
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      )
    );
  }

}