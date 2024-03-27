import 'package:flutter/material.dart';
import 'package:mvp_app/services/service.dart';

import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
class PostJobs extends StatefulWidget {
  final user_id;
  const PostJobs({super.key, this.user_id});

  @override
  State<PostJobs> createState() => _PostJobsState();
}

class _PostJobsState extends State<PostJobs> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _salaryController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 1.1,
        child: SingleChildScrollView(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Post Job Information',
                          style: MyText.subtitle(context)!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    color: Colors.grey[400],
                  ),

                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.format_size , color: MyColors.iconColor,),
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
                        hintText: 'Job Name',
                        hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.textColor1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  TextField(
                        controller: _descriptionController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.description, color: MyColors.iconColor),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Description',
                          hintStyle: TextStyle(fontSize: 14, color: MyColors.textColor1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _locationController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on_rounded , color: MyColors.iconColor,),
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
                        hintText: 'Location',
                        hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _salaryController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money , color: MyColors.iconColor,),
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
                        hintText: 'Salary',
                        hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
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
                          var body = {
                            "job_title":_titleController.text.toString(),
                            "description":_descriptionController.text.toString(),
                            "location":_locationController.text.toString(),
                            "user_id": widget.user_id.toString(),
                          };
                          await Service.postJobInfo(body, context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,// Make the button background transparent
                          elevation: 0, // Remove button elevation
                        ),
                        child: Text('Submit',style: MyText.subtitle(context)!
                            .copyWith(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
