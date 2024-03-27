import 'package:flutter/material.dart';
import 'package:mvp_app/services/service.dart';

import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import '../widgets/widgets.dart';
class EditJobs extends StatefulWidget {
  final String title;
  final String description;
  final String location;
  final String user_id;
  final String job_id;
  const EditJobs({super.key, required this.title, required this.description, required this.location,  required this.user_id, required this.job_id});

  @override
  State<EditJobs> createState() => _EditJobsState();
}

class _EditJobsState extends State<EditJobs> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  void setData(){
    setState(() {
      _titleController.text = widget.title;
      _descriptionController.text = widget.description;
      _locationController.text =widget.location;
    });
  }

  @override
  void initState(){
    super.initState();
    setData();
  }
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
                          'Edit Job Information',
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
                  Widgets.TextFildWidget(_titleController, 'Job Name', TextInputType.text, false),

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
                  Widgets.TextFildWidget(_locationController, 'Location', TextInputType.text, false),

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
                          await Service.updateJobInfo(body, widget.job_id.toString(), context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,// Make the button background transparent
                          elevation: 0, // Remove button elevation
                        ),
                        child: Text('Update',style: MyText.subtitle(context)!
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
