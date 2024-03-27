import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp_app/models/apiResponse.dart';
import 'package:mvp_app/services/service.dart';
import 'package:mvp_app/services/user_service.dart';

import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import '../widgets/widgets.dart';
class EditHouses extends StatefulWidget {
 final String rentalId;
 final String title;
 final String description;
 final String location;
 final String price;
 final String user_id;
  const EditHouses({super.key, required this.title, required this.user_id, required this.description, required this.location, required this.price, required this.rentalId});

  @override
  State<EditHouses> createState() => _EditHousesState();
}

class _EditHousesState extends State<EditHouses> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  void setData(){
    setState(() {
      _titleController.text = widget.title;
      _descriptionController.text = widget.description;
      _locationController.text =widget.location;
      _priceController.text = widget.price;
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
                          'Edit House Information',
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
                          borderRadius: BorderRadius.circular(35),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'House Name',
                        hintStyle: const TextStyle(fontSize: 14, color: MyColors.textColor1),
                      ),
                    ),
                  ),
                  Widgets.TextFildWidget(_titleController, 'House Name', TextInputType.text, false),
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
                          borderRadius: BorderRadius.circular(35),
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
                          borderRadius: BorderRadius.circular(35),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Price',
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
                                "title":_titleController.text.toString(),
                                "description":_descriptionController.text.toString(),
                                "location":_locationController.text.toString(),
                                "price":_priceController.text.toString(),
                                "photo":"default.jpg",
                                "user_id": widget.user_id.toString(),
                              };
                              await Service.updateHouseInfo(body, widget.rentalId.toString(), context);
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
