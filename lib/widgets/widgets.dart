import 'package:flutter/material.dart';
import 'package:mvp_app/constant/styles/colors.dart';
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

 static Widget TextFildWidget(controller, hint, type, isPass){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: isPass,
        keyboardType: type,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock , color: MyColors.iconColor,),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: MyColors.textColor1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: MyColors.textColor1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: '$hint',
          hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
        ),
      ),
    );
}
}
