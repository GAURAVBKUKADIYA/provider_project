import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/AuthProvider.dart';
import '../../resourses/StyaleResourse.dart';
import '../../widgets/MyPrimaryButton.dart';
import '../../widgets/MyTextBox.dart';
import 'RegisterAccount.dart';
import 'ViewScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  //LoginWithApi

  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();

  AuthProvider provider;

  Widget _addclick()
  {
    return  MyPrimaryButton(
      buttonText: "Login",
      onclick: ()async{
        var name = _name.text.toString();
        var pass = _pass.text.toString();


        if(name.length<=0)
        {

          Fluttertoast.showToast(
              msg: "Please Add Name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if(pass.length<=0)
        {

          Fluttertoast.showToast(
              msg: "Please Entre PassWord",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{


          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("name", name.toString());


          Map<String,String>params = {
            "name": name,
            "password": pass,
            "device_token":"12345678",
            "device_os":"android"
          };
          Map<String,String> heder = {
            "Content-Type":"application/json"
          };
          await provider.login(params,heder,context);
          if(provider.islogin)
          {
            Fluttertoast.showToast(
                msg: provider.msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("name", provider.userobj.name.toString());
            prefs.setString("islogin", "yes");

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>ViewScreen())
            );
          }
          else{
            Fluttertoast.showToast(
                msg: provider.msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }

      },
    );
  }

  Widget _loginform()
  {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          ispassword: false,
          controller: _name,
          keyboard: TextInputType.text,
          hinttext: "Name",
        ),
        SizedBox(height: 10,),
        Text("password",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          ispassword: true,
          controller: _pass,
          keyboard: TextInputType.text,
          hinttext: "Password",
        ),
      ],
    );
  }

  Widget _register()
  {
    return TextButton(
      onPressed: ()async{
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>RegisterAccount())
        );
      },
      child: Text("Did You Have An Account ?Register Account"),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<AuthProvider>(context,listen: false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("LoginScreen"),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _loginform(),
              SizedBox(height: 20,),
              _addclick(),
              SizedBox(height: 20,),
              _register()
            ],
          ),
        ),
      ),
    );
  }
}
