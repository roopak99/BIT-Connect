import 'package:bit_connect/widgets/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEventSceen extends StatefulWidget {
  @override
  _EditEventSceenState createState() => _EditEventSceenState();
  static const routeName = '/edit-event-screen';
}

class _EditEventSceenState extends State<EditEventSceen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('edit event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Form(
          child: Card(
            elevation: 5,
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
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Select Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Icon(Icons.calendar_today),
                            ]),
                      ),
                      Text(DateFormat('dd MMM yyyy').format(selectedDate))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
