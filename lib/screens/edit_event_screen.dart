import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  static const routeName = '/edit-event-screen';
  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  var _branches = [
    "CSE",
    "IT",
    "ETC",
    "EE",
    "EEE",
    "MECH",
    "CIVIL",
  ];
  var _batches = [
    "2020-2024",
    "2019-2023",
    "2018-2022",
    "2017-2021",
  ];
  var _currentSelectedBranch;
  var _currentSelectedBatch;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    var parsedDate = DateFormat('dd MMM yy').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text('edit event screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down_outlined),
                    hint: Text('Select Branch'),
                    value: _currentSelectedBranch,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _currentSelectedBranch = newValue;
                      });
                    },
                    items: _branches.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down_outlined),
                    hint: Text('Select Batch'),
                    value: _currentSelectedBatch,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _currentSelectedBatch = newValue;
                      });
                    },
                    items: _batches.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 100,
              child: InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tap here to set date :'),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                    Text(
                      'The date selected is : $parsedDate',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
