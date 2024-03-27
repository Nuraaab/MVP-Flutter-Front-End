import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvp_app/pages/splashScreen.dart';
import 'package:mvp_app/services/notifire.dart';
import 'constant/styles/colors.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FilterDataState(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: MyColors.navBarColor, // set status bar color here
        statusBarBrightness: Brightness.light
    ));
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const AnimatedSpalshScreen(),
    );
  }
}
