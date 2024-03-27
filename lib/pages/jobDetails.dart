import 'package:flutter/material.dart';
import 'package:mvp_app/components/snackbar.dart';
import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';

class JobDetailsDialog extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String phone;
  final String address;

  JobDetailsDialog({
    required this.title,
    required this.description,
    required this.location,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.1,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return  SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: 20.0,
              bottom: 20.0,
            ),
            margin: EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.work,
                  size: 40.0,
                  color: Colors.blue,
                ),
                SizedBox(height: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.0),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          // leading: Icon(Icons.description),
                          title: Text(
                            'Job Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(description),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(
                            'Location',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(location),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                            'Phone Number',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(phone),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.location_city),
                          title: Text(
                            'Address',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(address),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // Set the border radius
                          color: MyColors.buttonColor, // Set the background color
                        ),
                        child: ElevatedButton(

                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,// Make the button background transparent
                            elevation: 0, // Remove button elevation
                          ),
                          child: Text(
                            'Close',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all( 8.0),
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), // Set the border radius
                          color: MyColors.buttonColor, // Set the background color
                        ),
                        child: ElevatedButton(
                          onPressed: () async{

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,// Make the button background transparent
                            elevation: 0, // Remove button elevation
                          ),
                          child: Text('Apply',style: MyText.subtitle(context)!
                              .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}