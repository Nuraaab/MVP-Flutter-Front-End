import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import '../constant/styles/img.dart';
class RentalTab extends StatefulWidget {
 final List recommended;
  const RentalTab({super.key, required this.recommended});

  @override
  State<RentalTab> createState() => _RentalTabState();
}

class _RentalTabState extends State<RentalTab> {
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
    return  SizedBox(
      height: 220,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return SizedBox(
              width: 250,
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(Img.get('house.jpg',), fit: BoxFit.cover, height: 150, width: double.maxFinite, )),
                          if (user_id != widget.recommended[index].userId.toString())
                            Positioned(
                              top: -5,
                              right: -5,
                              child: PopupMenuButton<String>(
                                padding: EdgeInsets.all(0),
                                iconColor: Colors.white,
                                elevation: 4,
                                onSelected: (value) {
                                  if (value == 'edit') {

                                  } else if (value == 'delete') {

                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem<String>(
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
                      const SizedBox(height: 5,),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,),
                        width: double.infinity,
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${widget.recommended[index].title}',
                                style: MyText.subtitle(context)!
                                    .copyWith(color: Colors.grey[800])),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow[800], size: 18,),
                                const SizedBox(width: 2,),
                                const Text('(4.5)'),
                              ],)
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,),
                        width: double.infinity,
                        child:   Text('${widget.recommended[index].price}ETB',
                            style: MyText.subtitle(context)!
                                .copyWith(color: Colors.grey[500])),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,),
                        width: double.infinity,
                        child: Text('${widget.recommended[index].location}',
                            style: MyText.subtitle(context)!
                                .copyWith(color: Colors.grey[500])),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index)=> const Padding(padding: EdgeInsets.only(right: 5)),
          itemCount: widget.recommended.length
      ),
    );
  }
}
