

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:tech_week/main.dart';
import 'package:tech_week/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.red[400],
                    Colors.red[900],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
            ),
            child: _isLoading ? Center(child: CircularProgressIndicator()): ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                  loginSection(),
                ]
            )
        ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtName("Name", Icons.person),
          SizedBox(height: 30.0),
          txtAge("Age", Icons.format_list_numbered),
          SizedBox(height: 30.0),
          txtType("Type", Icons.panorama_horizontal),
          SizedBox(height: 30.0),
          txtEmail("Email", Icons.email),
          SizedBox(height: 30.0),
          txtPassword("Password", Icons.lock),
        ],
      ),
    );
  }



  signUp(String name, String age, String type, String email, String password) async{
    Map data = {
      'name' : name,
      'age' : age,
      'type' : type,
      'email': email,
      'password': password
    };
    var response = await http.post("http://10.0.0.109:3000/contacts/create", body: data);
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(response.statusCode == 201){
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setInt("token", jsonData['id']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
      });
    } else{
      print(response.body);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signUp(nameController.text, ageController.text, typeController.text, emailController.text, passwordController.text);
        },
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text("Sign Up", style: TextStyle(color: Colors.white)),
      )
    );
  }

  Container loginSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
        },
        child: Text("Already have an account? Login now!", style: TextStyle(color: Colors.black)),
      )
    );
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextFormField txtName(String title, IconData icon) {
    return TextFormField(
      controller: nameController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon),
      ),
    );
  }

  TextFormField txtAge(String title, IconData icon) {
    return TextFormField(
      controller: ageController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon),
      ),
    );
  }
  
  TextFormField txtType(String title, IconData icon) {
    return TextFormField(
      controller: typeController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon),
      ),
    );
  }

    TextFormField txtEmail(String title, IconData icon) {
    return TextFormField(
      controller: emailController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon),
      ),
    );
  }

  TextFormField txtPassword(String title, IconData icon) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon),
      ),
    );
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("ComedyAPP", style: TextStyle(color: Colors.white, fontSize: 40)),
    );
  }
}
