

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mvp_app/services/service.dart';

import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
class PostHouses extends StatefulWidget {
 final String user_id;
  const PostHouses({super.key, required this.user_id});

  @override
  State<PostHouses> createState() => _PostHousesState();
}

class _PostHousesState extends State<PostHouses> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  String fileName = '';


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
                          'Post House Information',
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
                        hintText: 'House Name',
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
                      controller: _priceController,
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
                        hintText: 'Price',
                        hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(allowMultiple: false);
                        if (result == null) return;
                        final files = result.files;
                        final path = files[0].path;
                        print('path: $path');
                        setState(() {
                          fileName = path!;
                        });
                      },
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_file, color: MyColors.iconColor),
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
                        hintText: 'Upload Image',
                        hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a file';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all( 8.0),
                    child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: MyColors.buttonColor,
                      ),
                      child: ElevatedButton(
                        onPressed: () async{
                          print("${_titleController.text} , ${_descriptionController.text} , ${_locationController.text} , ${_priceController.text}, ${fileName} , ${widget.user_id}");
                          var imageUrl = await Service.uploadImage(fileName);
                          var body = {
                            "title":_titleController.text.toString(),
                            "description":_descriptionController.text.toString(),
                            "location":_locationController.text.toString(),
                            "price":_priceController.text.toString(),
                            "photo":imageUrl,
                            "user_id": widget.user_id.toString(),
                          };
                          await Service.postHouseInfo(body, context);


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
