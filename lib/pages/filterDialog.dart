import 'package:flutter/material.dart';
class FilterDialog extends StatefulWidget {
  final List house;
  final List jobs;
  final Function setFilter;
  const FilterDialog({super.key, required this.house, required this.jobs, required this.setFilter});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool isChecked = false;
  List<dynamic> filteredHouse = [];
  List<dynamic> filteredJobs = [];
  String? selectedPriceRange;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Options'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioListTile(
              title: Text('10000-100000'),
              value: '10000-100000',
              groupValue: selectedPriceRange,
              onChanged: (String? value) {
                setState(() {
                  selectedPriceRange = value;
                  if (selectedPriceRange != null) {
                    filteredHouse = widget.house.where((house) {
                      int housePrice = int.tryParse(house.price) ?? 0;
                      return housePrice > 10000 && housePrice < 100000;
                    }).toList();
                    print('Filtered house: ${filteredHouse[0].price}');
                  } else {
                    filteredHouse = [];
                  }
                });
              },
            ),
            RadioListTile(
              title: Text('50000-200000'),
              value: '50000-200000',
              groupValue: selectedPriceRange,
              onChanged: (String? value) {
                setState(() {
                  selectedPriceRange = value;
                  if (selectedPriceRange != null) {
                    filteredHouse = widget.house.where((house) {
                      int housePrice = int.tryParse(house.price) ?? 0;
                      return housePrice > 50000 && housePrice < 200000;
                    }).toList();
                    // print('Filtered house: ${filteredHouse[0].price}');
                  } else {
                    filteredHouse = [];
                  }
                });
              },
            ),
            // Add more RadioListTile widgets for additional price ranges
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Apply'),
          onPressed: () {
            widget.setFilter(filteredHouse,filteredHouse);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );


  }
}
