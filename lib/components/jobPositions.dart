import 'package:flutter/material.dart';
import 'package:mvp_app/constant/styles/colors.dart';
import 'package:intl/intl.dart';
import 'package:mvp_app/pages/editJobs.dart';
import 'package:mvp_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/styles/fonts.dart';
import 'package:mvp_app/components/snackbar.dart';
import '../models/apiResponse.dart';
import '../pages/homeScreen.dart';
import '../pages/jobDetails.dart';
class JobPositions extends StatefulWidget {
  final List list;
  const JobPositions({super.key, required this.list});

  @override
  State<JobPositions> createState() => _JobPositionsState();
}

class _JobPositionsState extends State<JobPositions> {
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
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          String originalDate = widget.list[index].createdAt;
          DateTime dateTime = DateTime.parse(originalDate);
          String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
          return GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return JobDetailsDialog(
                    title: widget.list[index].jobTitle.toString(),
                    description: widget.list[index].description.toString(),
                    location: widget.list[index].location.toString(),
                    phone: widget.list[index].contact.phone.toString(),
                    address: widget.list[index].contact.address.toString(),);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                child: Card(
                  elevation: 4,
                  color: MyColors.grey_3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.work, size: 50,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${widget.list[index].jobTitle}',  style: MyText.medium(context)
                                        .copyWith(color: Colors.grey[800], fontSize:16)),
                                    SizedBox(width: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow[800], size: 18,),
                                        const SizedBox(width: 2,),
                                        const Text('(4.5)'),
                                      ],)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 15,),
                                    SizedBox(width: 2,),
                                    Text('${widget.list[index].location}', style: MyText.subtitle(context)!
                                        .copyWith(color: Colors.grey[500])),
                                  ],
                                ),
                                Text(formattedDate, textAlign: TextAlign.end,),


                              ],
                            ),
                          ],),
                        PopupMenuButton<String>(
                          iconColor: Colors.black,
                          onSelected: (value) {
                            if (value == 'edit') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditJobs(title: widget.list[index].jobTitle.toString(), description: widget.list[index].description.toString(), location: widget.list[index].location.toString(), user_id: widget.list[index].userId.toString(), job_id: widget.list[index].id.toString());
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
                                            ApiResponse deleteResponse = await deleteJob(widget.list[index].id.toString());
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
                            }else if(value == 'apply'){

                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              if (user_id == widget.list[index].userId.toString())
                                PopupMenuItem<String>(
                                  height: 30,
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit , size: 17,),
                                      SizedBox(width: 3,),
                                      Text('Edit', style: MyText.subtitle(context)!
                                          .copyWith(color: Colors.black)),
                                    ],
                                  ),
                                ),
                              if (user_id == widget.list[index].userId.toString())
                                PopupMenuItem<String>(
                                  height: 30,
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete , size: 17,),
                                      SizedBox(width: 3,),
                                      Text('Delete', style: MyText.subtitle(context)!
                                          .copyWith(color: Colors.black)),
                                    ],
                                  ),
                                ),
                              PopupMenuItem<String>(
                                height: 30,
                                value: 'apply',
                                child: Row(
                                  children: [
                                    Icon(Icons.send , size: 17,),
                                    SizedBox(width: 3,),
                                    Text('Apply', style: MyText.subtitle(context)!
                                        .copyWith(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ];
                          },

                        ),
                      ],),
                  ),

                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(bottom: 10)),
        itemCount: widget.list.length

    );
  }
}
