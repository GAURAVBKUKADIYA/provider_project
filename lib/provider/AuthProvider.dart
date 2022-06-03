import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Utility/ApiHandler.dart';
import '../Utility/ErrorHandler.dart';
import '../models/BegreatLoginModel.dart';
import '../resourses/UrlResourses.dart';
import '../view/Conaction/NoInterNetConaction.dart';

class AuthProvider extends ChangeNotifier{

  //login and register api

  var islogin = false;
  var msg = "";
  UseData userobj;

  login(params,heder,context)async{

    try{
      await ApiHandler.post(UrlResources.LOGIN,body:jsonEncode(params),headers: heder).then((json){
        if(json["result"]=="success")
        {
          islogin = true;
          msg=json["message"];
          userobj = UseData.fromJson(json["data"]);
        }
        else{
          islogin = false;
          msg=json["message"];
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.code.toString()=="500")
      {
        Navigator.of(context).push(
          MaterialPageRoute(builder:(context)=>NoConcation()),
        );
      }
    }

  }


  var isregister;
  var registermsg;
  register(context,params,headers)async{
    try{
      print(headers.toString());
      await ApiHandler.post(UrlResources.REGISTER,headers: headers,body: jsonEncode(params)).then((json){

        if(json["result"]=="failure")
        {
          isregister=false;
          registermsg = json["message"];
        }
        else
        {
          isregister=true;
          registermsg = json["message"];
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      print("Code : "+ex.code.toString());
      print("Exception : "+ex.message.toString());
      // if(ex.code.toString()=="500")
      // {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(builder:(context)=>NoConcation()),
      //   );
      // }
    }
  }

}