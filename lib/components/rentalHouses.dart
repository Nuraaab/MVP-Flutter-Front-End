
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mvp_app/constant/apiUrl.dart';
import 'package:mvp_app/models/apiResponse.dart';
import 'package:mvp_app/pages/houseDetail.dart';
import 'package:mvp_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvp_app/components/snackbar.dart';
import '../constant/styles/fonts.dart';
import '../constant/styles/img.dart';
import '../pages/editHouses.dart';
import '../pages/homeScreen.dart';
class RentalHouses extends StatefulWidget {
  List house;
   RentalHouses({super.key, required this.house});

  @override
  State<RentalHouses> createState() => _RentalHousesState();
}

class _RentalHousesState extends State<RentalHouses> {
  String user_id ='';
  String _token = '';

  void setUserData() async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    String userId= prefs.getString('user_id') ?? '';
    String token = prefs.getString('token') ?? '';
    setState(() {
      user_id = userId;
      _token = token;
    });
  }

  @override
  void initState(){
    super.initState();
    setUserData();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return  GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> HouseDetail(house: widget.house, index: index,)));
                },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: SizedBox(
                  //
                  width: double.maxFinite,
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Padding(padding: const EdgeInsets.only(bottom: 5),
                        child:Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  child: Image.network(
                                    '$getImageUrl/${widget.house[index].photo}',
                                    fit: BoxFit.cover,
                                    height: 300,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null)
                                        return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Image.asset(
                                        Img.get('appartment.jpg'), // Replace with your error image path
                                        fit: BoxFit.cover,
                                        height: 300,
                                      );
                                    },
                                  ),
                                ),
              
                                if (user_id == widget.house[index].userId.toString())
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PopupMenuButton<String>(
                                      iconColor: Colors.black,
                                      elevation: 4,
                                      onSelected: (value) {
                                        if (value == 'edit') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return EditHouses(title:widget.house[index].title, description: widget.house[index].description, location: widget.house[index].location, price: widget.house[index].price, user_id: widget.house[index].userId.toString(),  rentalId: widget.house[index].id.toString());
                                            },
                                          );
              
                                        } else if (value == 'delete') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FractionallySizedBox(
                                                widthFactor: 1.1,
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  title: Text("Confirm Deletion", style: MyText.medium(context)!
                                                      .copyWith(color: Colors.black), textAlign: TextAlign.center,),
                                                  content: Text("Are you sure you want to delete?", style: MyText.subtitle(context)!
                                                      .copyWith(color: Colors.black)),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("No"),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("Yes"),
                                                      onPressed: () async{
                                                        ApiResponse deleteResponse = await deleteHouse(widget.house[index].id.toString());
                                                        if(deleteResponse.error == null){
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
                                                          snackBar.show(
                                                              context,"${deleteResponse.message}", Colors.green);
                                                        }else{
                                                          Navigator.of(context).pop();
                                                          snackBar.show(
                                                              context,"${deleteResponse.message}", Colors.red);
                                                        }
                                                        // Close the dialog
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
              
                                        }
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem<String>(
                                            height: 30,
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit, size: 19,),
                                                SizedBox(width: 4,),
                                                Text('Edit',  style: MyText.subtitle(context)!
                                                    .copyWith(color: Colors.black)),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem<String>(
                                            height: 30,
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete, size: 19,),
                                                SizedBox(width: 4,),
                                                Text('Delete',  style: MyText.subtitle(context)!
                                                    .copyWith(color: Colors.black)),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
              
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${widget.house[index].title}',
                                          style: MyText.medium(context).copyWith(
                                            color: Colors.grey[800],
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
              
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow[800], size: 18,),
                                      const SizedBox(width: 2,),
                                      Text('(4.5)'),
                                    ],
                                  ),
                                ],
              
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              width: double.infinity,
                              child:   Text('${widget.house[index].price}ETB',
                                  style: MyText.subtitle(context)!
                                      .copyWith(color: Colors.grey[500])),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              width: double.infinity,
                              child: Text('${widget.house[index].location}',
                                  style: MyText.subtitle(context)!
                                      .copyWith(color: Colors.grey[500])),
                            ),
                          ],
                        ),
                      ),
              
                    ),
                  ),
              
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(bottom: 5)),
          itemCount: widget.house.length),
    );
  }
}
