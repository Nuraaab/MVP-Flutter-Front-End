import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvp_app/constant/styles/colors.dart';
import 'package:mvp_app/constant/styles/img.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvp_app/components/snackbar.dart';
import '../constant/apiUrl.dart';
import '../constant/styles/fonts.dart';
import '../models/apiResponse.dart';
import '../pages/homeScreen.dart';
import '../pages/login.dart';
import '../pages/postHouses.dart';
import '../pages/postJobs.dart';
import '../services/user_service.dart';
class PostListing extends StatefulWidget {
  const PostListing({super.key});

  @override
  State<PostListing> createState() => _PostListingState();
}

class _PostListingState extends State<PostListing> {
  String user_id ='';
  bool _isLoggedIn = false;
    void postHouse(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PostHouses(user_id: user_id.toString());
        },
      );
    }

    void postJobs(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PostJobs(user_id: user_id.toString());
        },
      );
    }
  logoutUser() async {
    ApiResponse logoutResponse = await logout();
    if(logoutResponse.error == null){
      SharedPreferences  prefs = await SharedPreferences.getInstance();
      prefs.setString('token', '');
      prefs.setString('user_id', '');
      prefs.setString('user', '');
      prefs.setBool('isLoggedIn', false);
      setState(() {
        _isLoggedIn = false;
      });
      snackBar.show(
          context,"${logoutResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${logoutResponse.message}", Colors.red);
    }
  }
  String user_data = '';
 String _name = '';
  void setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    String token = prefs.getString('token') ?? '';
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final storedData = prefs.getString('user') ?? '';
    setState(() {
      user_id = userId;
      _isLoggedIn = isLoggedIn;
      user_data = storedData;

    });
  }
  List<dynamic> _user = [];
  void getUserData() async {

    ApiResponse userResponse = await fetchUser();
    if(userResponse.error == null){
      List<dynamic> userList = userResponse.data as List<dynamic>;
      setState(() {
        _user = userList;
      });
    }else{
    }
  }
  @override
  void initState() {
    super.initState();
    setUserData();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: MyColors.buttonColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
          ),
          child: Column(
            children: [
              ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: Text('Hello, $_name',style: MyText.subtitle(context)!
                    .copyWith(color: Colors.white)),
              subtitle: Text("Welcome! You can post your job and house listings here.", style: MyText.subtitle(context)!
                  .copyWith(color: Colors.white)),
                trailing: CircleAvatar(
                  radius: 30,
                  backgroundImage: _user.isNotEmpty
                      ? NetworkImage('$getImageUrl/${_user[0].profile}') as ImageProvider<Object>?
                      : AssetImage(Img.get('default.png')),
                ),
              ),

            ],
          ),
        ),
        Container(
          color: MyColors.buttonColor,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(100))
            ),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: 2,
              shrinkWrap: true,
              children: [
                itemDashboard('Post Houses', Icons.upload, Colors.deepOrange, postHouse ),
                itemDashboard('Post Jobs', Icons.upload, Colors.deepOrange, postJobs),
                itemDashboard('Log Out', Icons.logout, Colors.deepOrange, logoutUser),
                // itemDashboard('Post Jobs', Icons.upload, Colors.deepOrange, postHouse)
              ],


            ),
          ),
        )
      ],
    ): Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.deepOrange,
      ),
      child: Column(
        children: [
          Text('Hello, welcome! Please create an account to access more of our features.', style: MyText.subtitle(context)!
              .copyWith(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all( 8.0),
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // Set the border radius
                color: MyColors.grey_5, // Set the background color
              ),
              child: ElevatedButton(
                onPressed: () async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const Login()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,// Make the button background transparent
                  elevation: 0, // Remove button elevation
                ),

                child: Text('Get Started',style: MyText.subtitle(context)!
                    .copyWith(color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  itemDashboard(String title, IconData upload, MaterialColor deepOrange, void Function() postHouse)=> GestureDetector(
    onTap: postHouse,
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
            BoxShadow(
              offset: Offset(0,5),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5
            )
        ]
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepOrange,
              shape: BoxShape.circle,
            ),
            child: Icon(upload, color: Colors.white,),
          ),
          SizedBox(height: 8,),
          Text(title, style: Theme.of(context).textTheme.titleMedium,)
        ],
      ),
    ),
  );
}
