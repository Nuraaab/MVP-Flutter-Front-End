import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:mvp_app/constant/apiUrl.dart';
import 'package:mvp_app/pages/homeScreen.dart';
import 'package:mvp_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/404.dart';
import '../models/apiResponse.dart';
import 'package:mvp_app/components/snackbar.dart';
class Service {
  static  Future<List<dynamic>> getHouseData(context) async {
    ApiResponse houseResponse = await fetchHouseData();
    if(houseResponse.error == null){
      List<dynamic> houseList = houseResponse.data as List<dynamic>;

      return houseList;
    }else if(houseResponse.error == '404'){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Error404()));
      return [];
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Error404()));
      return [];
    }
  }

  static  Future<List<dynamic>> getJobsData(context) async {
    ApiResponse jobResponse = await fetchJobData();
    if(jobResponse.error == null){
      List<dynamic> jobList = jobResponse.data as List<dynamic>;
      return jobList;
    }else if(jobResponse.error == '404'){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Error404()));
      return [];
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> Error404()));
      return [];
    }
  }

  static registerUserInfo(var body, context) async{
    ApiResponse userInfo = await registerUser(body);
    if(userInfo.error == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${userInfo.message}", Colors.green);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', userInfo.token ?? '');
      prefs.setString('user_id', userInfo.user_id ?? '');
      prefs.setString('user', userInfo.data.toString() ?? '');
      prefs.setBool('isLoggedIn', true);
    }else{
      snackBar.show(
          context,"${userInfo.message}", Colors.red);
    }
  }

  static loginUser(String? email, String? password, context) async{
    ApiResponse loginResponse = await login(email, password);
    if(loginResponse.error == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${loginResponse.message}", Colors.green);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginResponse.token ?? '');
      prefs.setString('user_id', loginResponse.user_id ?? '');
      prefs.setBool('isLoggedIn', true);
      prefs.setString('user', loginResponse.data.toString() ?? '');
    }else{
      snackBar.show(
          context,"${loginResponse.message}", Colors.red);

    }
  }

  static updateHouseInfo(var body, String id, context) async {
    ApiResponse updateResponse = await updateHouse(body, id);
    if(updateResponse.error == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${updateResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${updateResponse.message}", Colors.red);
    }
  }
  static postHouseInfo(var body, context) async {
    ApiResponse postResponse = await postHouses(body);
    if(postResponse.error == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${postResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${postResponse.message}", Colors.red);
    }
  }
  static postJobInfo(var body, context) async {
    ApiResponse postResponse = await postJob(body);
    if(postResponse.error == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${postResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${postResponse.message}", Colors.red);
    }
  }
  static updateJobInfo(var body, String id, context) async {
    ApiResponse updateResponse = await updateJob(body, id);
    if(updateResponse.error == null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${updateResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${updateResponse.message}", Colors.red);
    }
  }
  static logoutUser(context) async {
    ApiResponse logoutResponse = await logout();
    if(logoutResponse.error == null){
      SharedPreferences  prefs = await SharedPreferences.getInstance();
      prefs.setString('token', '');
      prefs.setString('user_id', '');
      prefs.setString('user', '');
      prefs.setBool('isLoggedIn', false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${logoutResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${logoutResponse.message}", Colors.red);
    }
  }
  static Future<String>   uploadImage(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(postImageUrl),
    );
    var file = File(filePath);
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'jpg'),
    );
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      var imageUrl = await response.stream.bytesToString();
      imageUrl = imageUrl.replaceAll('"', '');
      return imageUrl;
    } else {
      throw Exception('Image upload failed');
    }
  }
}


