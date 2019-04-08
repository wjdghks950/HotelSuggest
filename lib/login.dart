// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'signup.dart';
import 'colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/diamond.png',
                  color: kShrineBrown900),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            // [Name]
            TextField(
                controller:_usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  errorText: _validate ? 'Type a valid username' : null,
                ),
              ),
            // spacer
            SizedBox(height: 12.0),
            // [Password]
            TextField(
              controller:_passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
              ),
              obscureText: true,
            ),
            // TODO: Add button bar (101)
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                Wrap(
                    children: [
                      FlatButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          _usernameController.clear();
                          _passwordController.clear();
                        },
                      ),

                      FlatButton(
                        child: Text('Sign Up'),
                        onPressed:(){
                          Navigator.pushNamed(context, '/signup');
                        }
                      ),
                      RaisedButton(
                        child: Text('NEXT'),
                        onPressed: () {
                          setState((){
                            _usernameController.text.isEmpty ? _validate = true : _validate = false;
                            _passwordController.text.isEmpty ? _validate = true : _validate = false;
                            // Show the next page
                            /* if (!_validate){
                              Navigator.pop(context);
                            } */
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

  @override
  void dispose(){
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}

class AccentColorOverride extends StatelessWidget{
  const AccentColorOverride({Key key, this.color, this.child}) : super(key : key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context){
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      )
    );
  }
}