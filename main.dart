import 'package:flutter/material.dart';

import 'customtext.dart';
import 'homepage.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title:  CustomText(
          sTextToDisplay: 'Login Page',
          dTextSize: 26,
          bMakeBold: true,
          colorOfText: Colors.white,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25,10,25,20),
          child: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                    'assets/images/news.jpg',
                width: 170,
                height: 170,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white,fontSize: 18),
                  enabledBorder: OutlineInputBorder(
                    //borderSide: BorderSide(), // Border color for the enabled state
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(249, 174, 53, 1)), // Border color for the focused state
                  ),
                  filled: true, // Fill the input field background
                  fillColor: Colors.grey[800], // Background color for the input field
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(249, 174, 53, 1)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Replace with your authentication logic
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  if (username == 'shivanssh' && password == 'shivanssh123') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => NewsScreen()),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Invalid credentials.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: CustomText(
                  sTextToDisplay: 'Login',
                  dTextSize: 20,
                  bMakeBold: true,
                  colorOfText: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(249, 174, 53, 1), // Set the button background color
                ),
                ),
            ],
          ),
        ),
      ),

    ),
    backgroundColor: Colors.black87);
  }
}

