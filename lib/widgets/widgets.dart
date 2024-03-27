import 'package:flutter/material.dart';
class Widgets{
  static Widget menuButton(openMenu){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
            // border:Border.all(width: 0.7, color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ]
        ),
        child: IconButton(onPressed: ()=> {openMenu()}, icon: Icon(Icons.menu_rounded), color: Colors.black,),
      ),
    );
  }


}
