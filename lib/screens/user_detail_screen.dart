import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailScreen extends StatefulWidget {
  static const routeName = '/user-detail-screen';

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _form = GlobalKey<FormState>();
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
  var _initValues = {
    'username': '',
    'urollno': '',
    'branch': '',
    'batch': '',
  };
  String currentSelectedBranch;
  String currentSelectedBatch;
  String universityrn;
  String username;

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
  }

  Future<void> setUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;

    username = extractedUserData['username'];
    universityrn = extractedUserData['userurn'];
    currentSelectedBatch = extractedUserData['userbatch'];
    currentSelectedBranch = extractedUserData['userbranch'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['username'],
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value.isEmpty) return "Name is Compulsory";
                        if (value.length > 40)
                          return "Maximum limit of characters exceeded (40)";
                        return null;
                      },
                      onSaved: (value) {
                        username = value;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        icon: Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      initialValue: _initValues['urollno'],
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value.isEmpty) return "Roll Number is Compulsory";
                        if (value.length > 40)
                          return "Maximum limit of characters exceeded (40)";
                        return null;
                      },
                      onSaved: (value) {
                        universityrn = value;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'University Roll Number',
                        icon: Icon(Icons.format_list_numbered),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value.isEmpty) return "Branch must be selected";
                          return null;
                        },
                        onSaved: (val) {},
                        value: currentSelectedBranch,
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
                        onSaved: (val) {},
                        value: currentSelectedBatch,
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
                                print(
                                    '$universityrn $username $currentSelectedBatch $currentSelectedBranch');
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
        ),
      ),
    );
  }
}
