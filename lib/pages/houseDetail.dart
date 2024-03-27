import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvp_app/constant/styles/colors.dart';
import 'package:mvp_app/components/snackbar.dart';
import '../components/navigationMenu.dart';
import '../constant/apiUrl.dart';
import '../constant/styles/fonts.dart';
import '../constant/styles/img.dart';
import '../models/apiResponse.dart';
import '../services/user_service.dart';
import '../widgets/widgets.dart';
import 'editHouses.dart';
import 'homeScreen.dart';
class HouseDetail extends StatefulWidget {
  final List house;
  final int index;
  const HouseDetail({super.key, required this.house, required this.index});

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {

  @override
  Widget build(BuildContext context) {
    String originalDate = widget.house[widget.index].createdAt;
    DateTime dateTime = DateTime.parse(originalDate);
    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            iconColor: Colors.black,
            elevation: 4,
            onSelected: (value) {
              if (value == 'edit') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return EditHouses(title:widget.house[widget.index].title, description: widget.house[widget.index].description, location: widget.house[widget.index].location, price: widget.house[widget.index].price, user_id: widget.house[widget.index].userId.toString(),  rentalId: widget.house[widget.index].id.toString());
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
                              ApiResponse deleteResponse = await deleteHouse(widget.house[widget.index].id.toString());
                              if(deleteResponse.error == null){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
                                snackBar.show(
                                    context,"${deleteResponse.message}", Colors.green);
                              }else{
                                Navigator.of(context).pop();
                                snackBar.show(
                                    context,"${deleteResponse.message}", Colors.red);
                              }

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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              child: Image.network(
                '$getImageUrl/${widget.house[widget.index].photo}',
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
                    Img.get('apple.png'), // Replace with your error image path
                    fit: BoxFit.cover,
                    height: 300,
                  );
                },
              ),
            ),

            Card(
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(3.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      // leading: Icon(Icons.description),
                      title: Text(
                        '${widget.house[widget.index].title}',
                        style: MyText.medium(context).copyWith(
                          color: Colors.grey[800],
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      subtitle:  Row(
                        children: [
                          Icon(Icons.location_on, size: 19,),
                          Text('${widget.house[widget.index].location}',
                              style: MyText.subtitle(context)!
                                  .copyWith(color: Colors.grey[600])),

                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: widget.house[widget.index].profile != null ? NetworkImage('$getImageUrl/${widget.house[widget.index].profile}') as ImageProvider<Object>?
                                : AssetImage(Img.get('default.png')),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text(
                                'Posted By ${widget.house[widget.index].name}',
                                style: MyText.medium(context).copyWith(
                                  color: Colors.grey[600],
                                  fontSize: 17,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text('$formattedDate',
                                  style: MyText.subtitle(context)!
                                      .copyWith(color: Colors.grey[600])),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    ListTile(
                      // leading: Icon(Icons.description),
                      title: Text(
                        'Description',
                        style: MyText.medium(context).copyWith(
                          color: Colors.grey[800],
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      subtitle:   Text('${widget.house[widget.index].description}',
                        style: MyText.subtitle(context)!
                            .copyWith(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 100,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      // leading: Icon(Icons.description),
                      title: Text(
                        'Contact Information',
                        style: MyText.medium(context).copyWith(
                          color: Colors.grey[800],
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      subtitle:   Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.call),
                              SizedBox(width: 10,),
                              Text('${widget.house[widget.index].contact.phone}',
                                style: MyText.subtitle(context)!
                                    .copyWith(color: Colors.grey[600]),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 100,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_city),
                              SizedBox(width: 10,),
                              Text('${widget.house[widget.index].contact.address}',
                                style: MyText.subtitle(context)!
                                    .copyWith(color: Colors.grey[600]),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 100,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all( 8.0),
                          child: Container(
                            width: 200,
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
                              child: Text('Reserve',style: MyText.subtitle(context)!
                                  .copyWith(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
