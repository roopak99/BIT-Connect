import 'package:bit_connect/models/event.dart';
import 'package:bit_connect/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditedEvent {
  String eid;
  String title;
  String description;
  String imageURL;
  DateTime eventDate;
  String branch;
  String batch;
  bool isFavourite;

  EditedEvent({
    this.eid,
    this.title,
    this.description,
    this.eventDate,
    this.batch,
    this.branch,
    this.imageURL,
    isFavourite = false,
  });
}

class EditEventScreen extends StatefulWidget {
  static const routeName = '/edit-event-screen';
  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  TextEditingController _dateController = TextEditingController();
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
  String currentSelectedBranch;
  String currentSelectedBatch;
  final _form = GlobalKey<FormState>();
  var _editedEvent = EditedEvent();
  var _isLoading = false;

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

  var _isInit = true;

  var _initValues = {
    'title': '',
    'description': '',
    'date': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final eventId = ModalRoute.of(context).settings.arguments as String;
      if (eventId != null) {
        final _rcvdEvent =
            Provider.of<Events>(context, listen: false).findById(eventId);

        _editedEvent.batch = _rcvdEvent.batch;
        _editedEvent.eid = _rcvdEvent.eid;
        _editedEvent.title = _rcvdEvent.title;
        _editedEvent.branch = _rcvdEvent.branch;
        _editedEvent.description = _rcvdEvent.description;
        _editedEvent.eventDate = _rcvdEvent.eventDate;

        _initValues = {
          'title': _editedEvent.title,
          'description': _editedEvent.description,
          'date': '',
          'branch': _editedEvent.branch,
          'batch': _editedEvent.batch
        };
        _dateController.text =
            DateFormat('dd/MM/yyyy').format(_editedEvent.eventDate);
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    _form.currentState.save();

    if (_editedEvent.eid != null) {
      var _finalForm = Event(
        eid: _editedEvent.eid,
        description: _editedEvent.description,
        title: _editedEvent.title,
        batch: _editedEvent.batch,
        branch: _editedEvent.branch,
        eventDate: _editedEvent.eventDate,
      );

      await Provider.of<Events>(context, listen: false)
          .updateEvent(_finalForm.eid, _finalForm);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      var _finalForm = Event(
        eid: '',
        description: _editedEvent.description,
        title: _editedEvent.title,
        batch: _editedEvent.batch,
        branch: _editedEvent.branch,
        eventDate: _editedEvent.eventDate,
      );
      try {
        await Provider.of<Events>(context, listen: false).addEvent(_finalForm);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Something went wrong'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'))
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        validator: (value) {
                          if (value.isEmpty) return "Event title is Compulsory";
                          if (value.length > 40)
                            return "Maximum limit of characters exceeded (40)";
                          return null;
                        },
                        onSaved: (value) {
                          _editedEvent.title = value;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Event Title',
                          icon: Icon(Icons.title_rounded),
                        ),
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        onSaved: (value) {
                          _editedEvent.description = value;
                        },
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Event Description',
                          icon: Icon(Icons.description_rounded),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              onSaved: (val) {
                                _editedEvent.eventDate = selectedDate;
                              },
                              controller: _dateController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                labelText: "Event Date",
                                icon: Icon(Icons.calendar_today),
                              ),
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter a date for your event";
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value.isEmpty) return "Branch must be selected";
                            return null;
                          },
                          onSaved: (val) => _editedEvent.branch = val,
                          value: _initValues['branch'] != null
                              ? _initValues['branch']
                              : currentSelectedBranch,
                          items: _branches.map<DropdownMenuItem<String>>(
                            (String val) {
                              return DropdownMenuItem(
                                child: Text(val),
                                value: val,
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(() {
                              currentSelectedBranch = val;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Branch',
                            icon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value.isEmpty) return "Batch must be selected";
                            return null;
                          },
                          onSaved: (val) => _editedEvent.batch = val,
                          value: _initValues['batch'] != null
                              ? _initValues['batch']
                              : currentSelectedBatch,
                          items: _batches.map<DropdownMenuItem<String>>(
                            (String val) {
                              return DropdownMenuItem(
                                child: Text(val),
                                value: val,
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(() {
                              currentSelectedBatch = val;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Select Batch',
                            icon: Icon(Icons.group_rounded),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Transform.scale(
                              scale: 2,
                              child: IconButton(
                                color: Colors.green,
                                onPressed: () {
                                  _saveForm();
                                },
                                icon: Icon(Icons.save_rounded),
                              ),
                            ),
                            Transform.scale(
                              scale: 2,
                              child: IconButton(
                                color: Colors.red,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.cancel_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
