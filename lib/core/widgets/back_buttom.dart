import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  const BackButton({super.key,  this.backgroundColor=Colors.white, this.iconColor=Colors.black});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,

        ),
          color: iconColor,
        child: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
