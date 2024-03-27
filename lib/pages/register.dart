import 'package:flutter/material.dart';
import 'package:mvp_app/services/service.dart';
import 'package:mvp_app/components/snackbar.dart';
import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import '../constant/styles/img.dart';
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();


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
        title: Text("Sign Up",  style: MyText.medium(context)!
            .copyWith(color: Colors.black, fontSize:15 )),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined , color: MyColors.iconColor,),
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
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Name',
                  hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _phoneController,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.call , color: MyColors.iconColor,),
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
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _addressController,
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.contact_mail , color: MyColors.iconColor,),
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
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Address',
                  hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person , color: MyColors.iconColor,),
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
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Email',
                  hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
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
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Password',
                  hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                keyboardType: TextInputType.text,
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
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                ),
              ),
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
                    if(_nameController.text== "" || _emailController.text =="" || _phoneController.text == "" || _addressController.text == "" || _passwordController.text == "" || _confirmPasswordController.text ==""){
                      snackBar.show(
                          context,"All Field Required", Colors.red);
                    }else if(_passwordController.text != _confirmPasswordController.text){
                      snackBar.show(
                          context,"Password not matched", Colors.red);
                    }else{
                      var body= {
                        "name":_nameController.text,
                        "email":_emailController.text,
                        "phone_number":_phoneController.text,
                        "address":_addressController.text,
                        "password":_passwordController.text,
                        "confirm_password":_confirmPasswordController.text
                      };
                      await Service.registerUserInfo(body, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,// Make the button background transparent
                    elevation: 0, // Remove button elevation
                  ),
                  child: Text('Sign Up',style: MyText.subtitle(context)!
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
