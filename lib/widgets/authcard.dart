import 'dart:convert';

import 'package:bit_connect/models/http_exception.dart';
import 'package:bit_connect/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Error Occured'),
              content: Text(message),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            ));
  }

  Future<void> _submit() async {
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in

        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        // Sign user up

        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password']);
      }
      print(
          '$username $currentSelectedBatch $currentSelectedBranch $universityrn');
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'username': username,
        'userbranch': currentSelectedBranch,
        'userbatch': currentSelectedBatch,
        'userurn': universityrn,
      });
      prefs.setString('userData', userData);
    } on HttpException catch (error) {
      var errorMessage = "Authentication failed";
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = "Email already exists";
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = "Email not valid";
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = "Weak Password";
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = "Email not found. Sign up instead";
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = "Invalid username or password";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = "Could not authenticate";
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

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
  String universityrn;
  String username;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 600 : 280,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 600 : 280),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  _authMode == AuthMode.Signup ? 'Signup' : 'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    icon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return '';
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.password),
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 4) {
                      return 'Password is too short!';
                    }
                    return '';
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      icon: Icon(Icons.password),
                    ),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return '';
                          }
                        : null,
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
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
                if (_authMode == AuthMode.Signup)
                  TextFormField(
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
                if (_authMode == AuthMode.Signup)
                  DropdownButtonFormField<String>(
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
                      icon: Icon(Icons.person),
                      labelText: 'Select Branch',
                    ),
                  ),
                if (_authMode == AuthMode.Signup)
                  DropdownButtonFormField<String>(
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

                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  // ignore: deprecated_member_use
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
