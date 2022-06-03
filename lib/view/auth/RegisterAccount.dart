import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';


import '../../provider/AuthProvider.dart';
import '../../resourses/StyaleResourse.dart';
import '../../widgets/MyPrimaryButton.dart';
import '../../widgets/MyTextBox.dart';

class RegisterAccount extends StatefulWidget {


  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {

  TextEditingController _name = TextEditingController();
  TextEditingController _emai = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmpass = TextEditingController();


  AuthProvider provider;



  Widget _registerform(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _name,
          hinttext: "EntreYourName",
          ispassword: false,
          keyboard: TextInputType.text,
        ),
        SizedBox(height: 10,),
        Text("email",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _emai,
          hinttext: "EntreYouremail",
          ispassword: false,
          keyboard: TextInputType.emailAddress,
        ),
        SizedBox(height: 10,),
        Text("Create Password",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _pass,
          hinttext: "Password",
          ispassword: false,
          keyboard: TextInputType.number,
        ),
        SizedBox(height: 10,),
        Text("Confirm Password",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _confirmpass,
          hinttext: "ConfirmPassword",
          ispassword: true,
          keyboard: TextInputType.number,
        ),
      ],
    );
  }
  Widget _registerclick()
  {
    return MyPrimaryButton(
      buttonText: "Register",
      onclick: ()async{
        var name = _name.text.toString();
        var email = _emai.text.toString();
        var pass = _pass.text.toString();
        var confirmpass = _confirmpass.text.toString();

        if(name.length<=0)
        {
          Fluttertoast.showToast(
              msg: "Entere Your Name",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if(email.length<=0)
        {
          Fluttertoast.showToast(
              msg: "Entere Your Email",
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
              msg: "Create Your Password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if(pass.length<=4)
        {
          Fluttertoast.showToast(
              msg: "Must be greater than 5 letters",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if(confirmpass.length<=4)
        {
          Fluttertoast.showToast(
              msg: "Must be greater than 5 letters",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if(confirmpass.length<=0)
        {
          Fluttertoast.showToast(
              msg: "Add Your Confirm Password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if(pass!=confirmpass)
        {
          Fluttertoast.showToast(
              msg: "Both password must match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
          DateTime dateTime = DateTime.now();
          Map<String,String> params = {
            "name": name,
            "email": email,
            "password": pass,
            "confirm_password": confirmpass,
            "device_token":"12345678",
            "device_os": Platform.operatingSystem,
            "version_type":"openness",
            "group":"2",
            "version":"1",
            "time_zone":dateTime.timeZoneName,
            "ip_address": "103.232.125.6"
          };

          Map<String,String> headers = {
            "Content-Type": "application/json",
          };

          await provider.register(context,params,headers);
          if(provider.isregister)
          {
            Fluttertoast.showToast(
                msg: provider.registermsg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.of(context).pop();
          }
          else
          {
            Fluttertoast.showToast(
                msg: provider.registermsg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      },

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
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              _registerform(),
              SizedBox(height: 20),
              _registerclick()
            ],
          ),
        ),
      ),
    );
  }
}

