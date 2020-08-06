

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:tech_week/main.dart';
import 'package:tech_week/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.red[900],
                    Colors.redAccent[700],
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
                  registerSection(),
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
          txtEmail("Email", Icons.email),
          SizedBox(height: 30.0),
          txtPassword("Senha", Icons.lock),
        ],
      ),
    );
  }



  Future<String> signIn(String email, String password) async{

    var response = await http.get(
        Uri.encodeFull("http://10.0.0.109:3000/contacts"),
        headers: {
          "Accept": "application/json"
        }
    );
    var jsonData = null;
    var auth = false;
    var cont = 0;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      for (var i = 0; i < jsonData.length ; i++) {
        if (jsonData[i]['email'] == email && jsonData[i]['password'] == password){
          auth = true;
          cont = 1;
          break;
        } 
      }if(auth){
        setState(() {
          _isLoading = false;
          sharedPreferences.setInt("token", jsonData[cont]['id']);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
        });
      } else{
        setState(() {
          _isLoading = false;
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
        });

      }
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
          signIn(emailController.text, passwordController.text);
        },
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text("Entrar", style: TextStyle(color: Colors.white)),
      )
    );
  }

  Container registerSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => RegisterPage()), (Route<dynamic> route) => false);
        },
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Ainda não tem uma conta? Cadastre-se agora!", style: TextStyle(color: Colors.black)
            ),
        ),
      )
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
      margin: EdgeInsets.only(top: 10.0),
      child: Image(
        image: AssetImage('assets/logo_certa.jpeg'),              
        height: 100,
        width: 100,
        ),
    );
  }
}
