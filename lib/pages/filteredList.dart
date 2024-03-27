import 'package:flutter/material.dart';
import 'package:mvp_app/services/notifire.dart';
import 'package:provider/provider.dart';
import '../components/jobPositions.dart';
import '../components/rentalHouses.dart';

class FilterData extends SearchDelegate {
  final List houses;
  final List jobs;
  final String user_id;
  bool isRental;

  FilterData({
    required this.houses,
    required this.jobs,
    required this.user_id,
    required this.isRental,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filterDataState = Provider.of<FilterDataState>(context);
    final _houses = houses
        .where((house) => house.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final _jobs = jobs
        .where((job) => job.jobTitle.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return DefaultTabController(
      length: 2,
      child: Consumer<FilterDataState>(
        builder: (context, state, _) {
          return ListView(
            padding: EdgeInsets.all(8),
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 15),
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.green,
                splashBorderRadius: BorderRadius.all(Radius.circular(8)),
                onTap: (index) {
                  state.setCurrentIndex(index);
                },
                tabs: const [
                  Tab(
                    icon: Icon(Icons.house_siding_outlined),
                    text: 'House Rental',
                  ),
                  Tab(
                    icon: Icon(Icons.work),
                    text: 'Job Positions',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(height: 5,),
              IndexedStack(
                index: state.currentIndex,
                children: [
                  RentalHouses(house: _houses),
                  JobPositions(list: _jobs),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}