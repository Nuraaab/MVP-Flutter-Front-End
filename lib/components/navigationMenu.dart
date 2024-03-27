
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mvp_app/constant/apiUrl.dart';
import 'package:mvp_app/models/apiResponse.dart';
import 'package:mvp_app/pages/homeScreen.dart';
import 'package:mvp_app/services/service.dart';
import 'package:mvp_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import '../constant/styles/img.dart';
import '../pages/login.dart';
import '../pages/postHouses.dart';
import '../pages/postJobs.dart';
import 'package:mvp_app/components/snackbar.dart';
class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  String user_data = '';
  String _name = '';
  String _profile = '';
  String user_id ='';
  String fileName = '';
  void setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final storedData = prefs.getString('user') ?? '';
    setState(() {
      user_id = userId;
      _isLoggedIn = isLoggedIn;
      user_data = storedData;
      if(_isLoggedIn){
        _name = user_data.split(',')[1].split(':')[1].trim();
        _profile = user_data.split('profile:')[1].split(',')[0].trim();
        if (_profile.endsWith('}')) {
          _profile = _profile.substring(0, _profile.length - 1);
        }
        print('$user_data , $_profile');
      }

    });
  }
   logoutUser(context) async {
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      snackBar.show(
          context,"${logoutResponse.message}", Colors.green);
    }else{
      snackBar.show(
          context,"${logoutResponse.message}", Colors.red);
    }
  }
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final files = result.files;
    final path = files[0].path;
    print('path: $path');
    setState(() {
      fileName = path!;
    });
    print('path2: $fileName');
    var imageUrl = await Service.uploadImage(fileName);
  ApiResponse  editResponse = await updateProfile(imageUrl, user_id);
  if(editResponse.error == null){
    snackBar.show(
        context,"${editResponse.message}", Colors.green);
  }else{
    snackBar.show(
        context,"${editResponse.message}", Colors.red);
  }
  }
  @override
  void initState() {
    super.initState();
    setUserData();
  }
  bool _isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _isLoggedIn ? 230 : 200,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    Img.get('nav.jpg'),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: _isLoggedIn ? Colors.black.withOpacity(0.8): Colors.black.withOpacity(0.1)),
                  _isLoggedIn ?  Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Container(
                                  width:300,
                                  child: Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: ClipOval(
                                          child:  Container(
                                            width: 100,
                                            height: 100,
                                            child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: _profile.isNotEmpty
                                                ? NetworkImage('$getImageUrl/$_profile') as ImageProvider<Object>?
                                                : AssetImage(Img.get('default.png')),
                                          ),
                                        ),
                                      ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(_name,
                                          textAlign: TextAlign.center,
                                          style: MyText.body1(context)!.copyWith(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 3,),
                                    ],
                                  ),
                                ),
                                CustomeButton(title:'Pick Profile Image', icon: Icons.image_outlined, onClick:()=> _pickImage()),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      )) : Text(''),
                ],
              ),
            ),
            ListTile(
              title: Text("Home",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.home, size: 25.0, color: Colors.black,),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomeScreen()));
              },
            ),
            if(_isLoggedIn)
            ListTile(
              title: Text("Post House Listings",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.house, size: 25.0, color: Colors.black,),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PostHouses(user_id: user_id.toString());
                  },
                );
              },
            ),
            if(_isLoggedIn)
            ListTile(
              title: Text("Post Job Listings",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.work, size: 25.0, color: Colors.black,),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PostJobs(user_id: user_id.toString());
                  },
                );
              },
            ),
            ListTile(
              title: Text("About",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.info, size: 25.0, color: Colors.black,),
              onTap: () {

              },
            ),
            ListTile(
              title: Text("Contact",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.person, size: 25.0, color: Colors.black,),
              onTap: () {

              },
            ),
             Padding(
              padding: EdgeInsets.only(right: 5),
              child: Divider(color: Colors.grey[500],),
            ),
            if(!_isLoggedIn)
            ListTile(
              title: Text("Log In",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.login, size: 25.0, color: Colors.black,),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const Login()));
              },
            ),
            if(_isLoggedIn)
            ListTile(
              title: Text("Log Out",
                  style: MyText.subhead(context)!.copyWith(
                      color: Colors.black,   fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.logout, size: 25.0, color: Colors.black,),
              onTap: () async{
                await logoutUser(context);
                setState(() {
                  _isLoggedIn =false;
                });
              },
            ),


          ],
        ),
      ),
    );
  } Widget CustomeButton({required String title, required IconData icon, required VoidCallback onClick}){
    return Container(
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.buttonColor, // Change background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Set border radius to 0 for no border radius
          ),
        ),
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon, color: Colors.white,),
            SizedBox(width: 20,),
            Text(
              title,
              style: TextStyle(
                color: Colors.white, // Change text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
