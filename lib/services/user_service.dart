import 'dart:convert';

import 'package:mvp_app/constant/apiUrl.dart';
import 'package:mvp_app/models/jobs.dart';
import 'package:mvp_app/models/user.dart';
import '../models/apiResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/houses.dart';
Future<ApiResponse> fetchHouseData() async {
  ApiResponse houseResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(Uri.parse(houseUrl),

    headers: { "Authorization": "Bearer $token"}
    );
    switch(response.statusCode){
      case 200:
        houseResponse.data = List<House>.from(jsonDecode(response.body).map((x) => House.fromJson(x)));
        break;
      case 404:
        houseResponse.error = error404;
        break;
      default:
        houseResponse.error = something;
    }
  }catch(e){
    print('Error :$e');
    houseResponse.error = something;
  }
  return houseResponse;
}

Future<ApiResponse> fetchJobData() async {
  ApiResponse jobResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(Uri.parse(jobUrl),
        headers: { "Authorization": "Bearer $token"}
    );
    switch(response.statusCode){
      case 200:
        jobResponse.data = List<Job>.from(jsonDecode(response.body).map((x) => Job.fromJson(x)));
        break;
      case 404:
        jobResponse.error = error404;
        break;
      default:
        jobResponse.error = something;
    }
  }catch(e){
    jobResponse.error = something;
  }
  return jobResponse;
}


Future<ApiResponse> registerUser(var body) async{
  ApiResponse userResponse = ApiResponse();
  try{
  final response = await http.post(Uri.parse(registerUrl),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
  );
  switch(response.statusCode){
    case 200:

      userResponse.data = json.decode(response.body)['user'];
      userResponse.token = json.decode(response.body)['token'];
      userResponse.message =json.decode(response.body)['message'];
      userResponse.user_id = json.decode(response.body)['user']['id'].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', userResponse.token ?? '');
      prefs.setString('user_id', userResponse.user_id ?? '');
      prefs.setBool('isLoggedIn', true);
      prefs.setString('user', userResponse.data.toString() ?? '');
      break;
    default:
      userResponse.error = json.decode(response.body)['message'];
      userResponse.message = something;
      break;
  }
  }catch(e){
  userResponse.error ='$something  $e';
  userResponse.message = something;
  }
  return userResponse;
}


Future<ApiResponse> login(String? email, String? password) async {
  ApiResponse userResponse = ApiResponse();
  try{
    final response = await http.post(Uri.parse(loginUrl),
        body: json.encode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
        );
    switch(response.statusCode){
      case 200:
        userResponse.data = json.decode(response.body)['user'];
        userResponse.token =json.decode(response.body)['token'];
        userResponse.message = json.decode(response.body)['message'];
        userResponse.user_id = json.decode(response.body)['user']['id'].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', userResponse.token ?? '');
        prefs.setString('user_id', userResponse.user_id ?? '');
        prefs.setBool('isLoggedIn', true);
        prefs.setString('user', userResponse.data.toString() ?? '');
        break;
      case 400:
        userResponse.error= json.decode(response.body)['message'];
        userResponse.message = json.decode(response.body)['message'];
        break;
      case 401:
        userResponse.error= json.decode(response.body)['message'];
        userResponse.message = json.decode(response.body)['message'];
        break;
      default:
        userResponse.error= json.decode(response.body)['message'];
        userResponse.message = json.decode(response.body)['message'];
        break;
    }
  }catch(e){
    userResponse.error = something;
    userResponse.message = something;
  }
  return userResponse;
}
    Future<ApiResponse> postHouses(var body) async {
      ApiResponse houseResponse = ApiResponse();
    try{
      SharedPreferences  prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token') ?? '';
        final response = await http.post(
          Uri.parse(postHouseUrl),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
        );
        print(response.statusCode);
      switch(response.statusCode){
        case 200:
          houseResponse.data = json.decode(response.body);
          houseResponse.message = json.decode(response.body)['message'];
          break;
        default:
          houseResponse.error = json.decode(response.body)['message'];
          houseResponse.message = json.decode(response.body)['message'];
      }
    }catch(e){
      houseResponse.error = '$something $e';
      houseResponse.message = '$something $e';
      print('$something $e');
    }
    return houseResponse;
    }
Future<ApiResponse> updateHouse(var body, String? id) async{
  ApiResponse updateResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.post(Uri.parse('$updatHouseUrl/$id'),
    body: jsonEncode(body),
    headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    print(response.statusCode);
    switch(response.statusCode){
      case 200:
        updateResponse.data = json.decode(response.body);
        updateResponse.message = json.decode(response.body)['message'];
      default:
        updateResponse.error = json.decode(response.body)['message'];
        updateResponse.message = json.decode(response.body)['message'];
    }
  }catch(e){
    updateResponse.error = '$something $e';
    updateResponse.message = '$something $e';
    print('$something $e');
  }
  return updateResponse;
}

Future<ApiResponse> deleteHouse(String id) async {
  ApiResponse deleteResponse = new ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.delete(Uri.parse('$deleteHouseUrl/$id'),
    headers: {"Authorization": "Bearer $token"}
    );
    switch(response.statusCode){
      case 200:
        deleteResponse.message = json.decode(response.body)['message'];
        break;
      case 404:
        deleteResponse.message = json.decode(response.body)['message'];
        deleteResponse.error = json.decode(response.body)['message'];
        break;
      default:
        deleteResponse.error=something;
        deleteResponse.message=something;
    }
  }catch(e){
    deleteResponse.error=something;
    deleteResponse.message=something;
  }

  return deleteResponse;
}

Future<ApiResponse> postJob(var body) async{
  ApiResponse postResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.post(Uri.parse('$postJobUrl'),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    switch(response.statusCode){
      case 200:
        postResponse.data = json.decode(response.body);
        postResponse.message = json.decode(response.body)['message'];
      default:
        postResponse.error = json.decode(response.body)['message'];
        postResponse.message = json.decode(response.body)['message'];
    }
  }catch(e){
    postResponse.error = '$something $e';
    postResponse.message = '$something $e';
    print('$something $e');
  }
  return postResponse;
}

Future<ApiResponse> updateJob(var body, String? id) async{
  ApiResponse updateResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.post(Uri.parse('$updateJobUrl/$id'),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    switch(response.statusCode){
      case 200:
        updateResponse.data = json.decode(response.body);
        updateResponse.message = json.decode(response.body)['message'];
      default:
        updateResponse.error = json.decode(response.body)['message'];
        updateResponse.message = json.decode(response.body)['message'];
    }
  }catch(e){
    updateResponse.error = '$something $e';
    updateResponse.message = '$something $e';
    print('$something $e');
  }
  return updateResponse;
}

Future<ApiResponse> deleteJob(String id) async {
  ApiResponse deleteResponse = new ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.delete(Uri.parse('$deleteJobUrl/$id'),
    headers: {"Authorization": "Bearer $token"}
    );
    switch(response.statusCode){
      case 200:
        deleteResponse.message = json.decode(response.body)['message'];
        break;
      case 404:
        deleteResponse.message = json.decode(response.body)['message'];
        deleteResponse.error = json.decode(response.body)['message'];
        break;
      default:
        deleteResponse.error=something;
        deleteResponse.message=something;
    }
  }catch(e){
    deleteResponse.error=something;
    deleteResponse.message=something;
  }

  return deleteResponse;
}

Future<ApiResponse> updateProfile(String imageUrl) async{
  ApiResponse profileResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String id =prefs.getString('user_id')?? '';
    print('id : $id');
    final response = await http.post(Uri.parse('$editUserUrl/$id'),
      body: jsonEncode({"profile": imageUrl}),
      headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
    );
    switch(response.statusCode){
      case 200:
        profileResponse.data = json.decode(response.body);
        profileResponse.message = json.decode(response.body)['message'];
      default:
        profileResponse.error = json.decode(response.body)['message'];
        profileResponse.message = json.decode(response.body)['message'];
    }
  }catch(e){
    profileResponse.error = '$something $e';
    profileResponse.message = '$something $e';
    print('$something $e');
  }
  return profileResponse;
}

Future<ApiResponse> logout() async{
  ApiResponse logoutResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.post(Uri.parse('$logoutUrl'),
      headers: {"Authorization": "Bearer $token"},
    );
    switch(response.statusCode){
      case 200:
        logoutResponse.message = response.body;
      default:
        logoutResponse.error = response.body;
        logoutResponse.message = response.body;
    }
  }catch(e){
    logoutResponse.error = '$something $e';
    logoutResponse.message = '$something $e';
    print('$something $e');
  }
  return logoutResponse;
}

Future<ApiResponse> fetchUser() async {
  ApiResponse userResponse = ApiResponse();
  try{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String id = prefs.getString('user_id') ?? '';
    final response = await http.get(Uri.parse('$getUserUrl/$id'),

        headers: { "Authorization": "Bearer $token"}
    );
    switch(response.statusCode){
      case 200:
        userResponse.data = List<User>.from(jsonDecode(response.body).map((x) => User.fromJson(x)));
        break;
      case 404:
        userResponse.error = error404;
        break;
      default:
        userResponse.error = something;
    }
  }catch(e){
    print('Error :$e');
    userResponse.error = something;
  }
  return userResponse;
}