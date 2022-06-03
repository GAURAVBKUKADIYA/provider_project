import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class ApiPrc extends StatefulWidget {


  @override
  State<ApiPrc> createState() => _ApiPrcState();
}

class _ApiPrcState extends State<ApiPrc> {

  bool _isload = false;


  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Text("Name"),
              TextField(
                controller: _name,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20,),
              Text("Password"),
              TextField(
                controller: _pass,
                keyboardType: TextInputType.text,
              ),

              Center(
                child: ElevatedButton(
                  onPressed: ()async{

                    setState(() {
                      _isload=true;
                    });

                    var name = _name.text.toString();
                    var pass = _pass.text.toString();

                    Uri url = Uri.parse("https://begratefulapp.ca/api/login");

                    Map<String,String> parms = {
                      "name": name,
                      "password": pass,
                      "device_token":"12345678",
                      "device_os":"android"
                    };

                    var heder = {
                      "Content-Type":"application/json"
                    };

                    var response = await http.post(url,body: jsonEncode(parms),headers:heder);
                    if(response.statusCode==200)
                    {
                      var json =jsonDecode(response.body);
                      if(json["result"]=="success"){
                        Fluttertoast.showToast(
                            msg: "LoginSucsessfuly",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );


                        //this data view next page and create method getdata
                        var name = json ["data"]["name"];
                        var id = json ["data"]["id"];

                        //storeShartedPrefrence
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("name", name.toString());
                        prefs.setString("id", id.toString());

                        setState(() {

                          _isload=false;
                        });

                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "SomthingWrong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    }




                  },
                  child: Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
