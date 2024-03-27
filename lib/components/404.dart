import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/styles/fonts.dart';
import '../constant/styles/img.dart';


class Error404 extends StatelessWidget {
  Widget? routeWidget;
  Error404({super.key, this.routeWidget}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 400,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(Img.get('404.json'), height: 200),
              SizedBox(height: 10,),
              Text('Please check your connection and try again.',
                style: MyText.body1(context)!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
