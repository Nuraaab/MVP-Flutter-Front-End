import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp_app/components/navigationMenu.dart';
import 'package:mvp_app/pages/filteredList.dart';
import 'package:mvp_app/services/service.dart';
import 'package:mvp_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/jobPositions.dart';
import '../components/postListings.dart';
import '../components/rentalHouses.dart';
import '../constant/styles/colors.dart';
import '../constant/styles/fonts.dart';
import 'login.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void openMenu() {
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  void initState() {
    super.initState();
    _loadData();
    setUserData();
  }

  List<dynamic> _house = [];
  List<dynamic> _job = [];
  List<dynamic> _recomendded = [];

  Future<void> _loadData() async {
    List<dynamic> houseData = await Service.getHouseData(context);
    List<dynamic> jobData = await Service.getJobsData(context);
    setState(() {
      _house = houseData;
      _job = jobData;
    });
  }
  late List<Widget>  pages =[
    RentalHouses(house: _house),
    JobPositions(list: _job),
    PostListing(),
  ];
  bool _isRental = true;
   int currentIndex =0;
  void setFilter(house, jobs){
    setState(() {
      _house=house;
      _job=jobs;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Widgets.menuButton(openMenu),
        title: Text("MVP",style: MyText.medium(context)!
            .copyWith(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),

                  color: Colors.white,
                  // border:Border.all(width: 0.7, color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ]
              ),
              child: IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: FilterData(
                      houses: _house,
                      jobs: _job,
                      user_id: user_id,
                      isRental: _isRental,
                    ),
                  );
                },
                icon: Icon(Icons.search_rounded),
                color: Colors.black,
              ),
            ),
          ),

        ],
      ),
      drawer: const NavigationMenu(),
      body: (_house.isEmpty && _job.isEmpty) ? Center(
        child: Container(
          height: 230,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.deepOrange,
          ),
          child: Column(
            children: [
              Text('Hello, welcome! There are no available listings at the moment. Please create an account and create your own listings..', style: MyText.subtitle(context)!
                  .copyWith(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all( 8.0),
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), // Set the border radius
                    color: MyColors.grey_5, // Set the background color
                  ),
                  child: ElevatedButton(
                    onPressed: () async{
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const Login()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,// Make the button background transparent
                      elevation: 0, // Remove button elevation
                    ),

                    child: Text('Get Started',style: MyText.subtitle(context)!
                        .copyWith(color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),) : DefaultTabController(
        length: 3,
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            const SizedBox(height: 15,),
             TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Colors.black,
                indicatorColor: MyColors.buttonColor,
                dividerColor: Colors.red[200],
                labelColor: Colors.black,
                labelStyle: MyText.subtitle(context)!
                 .copyWith(color: Colors.black),
                splashBorderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: (index){
                 setState(() {
                   currentIndex = index;
                 });
                },
                tabs: const [
                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(Icons.house_siding_outlined, size: 30,),
                    text: 'Houses For Rental',
                  ),
                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(Icons.work, size: 30,),
                    text: 'Job Positions',
                  ),
                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 4),
                    icon: Icon(Icons.upload, size: 30,),
                    text: 'Post Listings',
                  ),
                ]
            ),
             const SizedBox(height: 15,),
            pages[currentIndex],
          ],
        )
      ),
    );
  }
}

