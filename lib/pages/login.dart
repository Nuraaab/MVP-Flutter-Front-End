
import 'package:flutter/material.dart';
import 'package:mvp_app/components/snackbar.dart';
import 'package:mvp_app/constant/styles/img.dart';
import 'package:mvp_app/pages/register.dart';
import 'package:mvp_app/services/service.dart';
import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import '../widgets/widgets.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        toolbarHeight: 35,
        title: Text("Log In Or Sign Up",  style: MyText.medium(context)!
            .copyWith(color: Colors.black, fontSize:15 )),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 1,
              color: Colors.grey[400],
            ),
            SizedBox(height: 15,),
            Widgets.TextFildWidget(_emailController, 'Email', TextInputType.emailAddress, false, Icons.mail),
            Widgets.TextFildWidget(_passwordController, 'Password', TextInputType.text, true, Icons.lock),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_) =>Register()));}, child: Text("New user? Sign Up", style: TextStyle(fontSize: 12, color: Colors.black),),),
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Set the border radius
                  color: MyColors.buttonColor, // Set the background color
                ),
                child: ElevatedButton(
                  onPressed: () async{
                    if(_emailController.text == ""|| _passwordController.text ==""){
                      snackBar.show(
                          context,"All Field Required", Colors.red);
                    }else{
                      await Service.loginUser(_emailController.text, _passwordController.text, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,// Make the button background transparent
                    elevation: 0, // Remove button elevation
                  ),
                  child: Text('Log In',style: MyText.subtitle(context)!
                      .copyWith(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                  width: MediaQuery.of(context).size.width/2-20,
                  height: 1,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 3,),
                Text('Or',style: TextStyle(color: MyColors.textColor1),),
                Container(
                  width: MediaQuery.of(context).size.width/2-20,
                  height: 1,
                  color: Colors.grey[400],
                ),



              ],),

            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border:  Border.all(
                    color: MyColors.textColor1,
                  ),
                  borderRadius: BorderRadius.circular(5), // Set the border radius
                  color: MyColors.grey_3, // Set the background color
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,// Make the button background transparent
                    elevation: 0, // Remove button elevation
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Image.asset(
                        Img.get('google.png'),
                        width: 30,
                        height: 30,
                      )
                      ),
                      SizedBox(width: 5,),
                      Text('Continue With Google',style: MyText.subtitle(context)!
                          .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border:  Border.all(
                    color: MyColors.textColor1,
                  ),
                  borderRadius: BorderRadius.circular(5), // Set the border radius
                  color: MyColors.grey_3, // Set the background color
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,// Make the button background transparent
                    elevation: 0, // Remove button elevation
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Image.asset(
                        Img.get('facebook.png'),
                        width: 30,
                        height: 30,
                      )
                      ),
                      SizedBox(width: 5,),
                      Text('Continue With Facebook',style: MyText.subtitle(context)!
                          .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all( 8.0),
              child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border:  Border.all(
                    color: MyColors.textColor1,
                  ),
                  borderRadius: BorderRadius.circular(5), // Set the border radius
                  color: MyColors.grey_3, // Set the background color
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black,// Make the button background transparent
                    elevation: 0, // Remove button elevation
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Image.asset(
                        Img.get('apple.png'),
                        width: 30,
                        height: 30,
                      )
                      ),
                      SizedBox(width: 5,),
                      Text('Continue With Apple',style: MyText.subtitle(context)!
                          .copyWith(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
