import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utility/ApiHandler.dart';
import '../Utility/ErrorHandler.dart';
import '../models/ViewProductsModel.dart';
import '../resourses/UrlResourses.dart';
import '../view/Conaction/NoInterNetConaction.dart';

class ProductProvider extends ChangeNotifier{


  var isinserted=false;
  var isdelete = false;
  var  isupdted = false;

  addproduct(context,params)async{
    try{
      await ApiHandler.post(UrlResources.ADDPRODUCT,body: params).then((json){
        if(json["status"]=="true")
        {
          isinserted=true;
        }
        else
        {
          isinserted=false;
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      if (ex.code.toString() == "500")
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>NoConcation())
        );
      }
    }
  }

  List<Product> alldata;

  viewproduct(context)async{
    try{
      await ApiHandler.get(UrlResources.VIEWPRODUCT).then((json){
        alldata = json["data"]
            .map<Product>((obj) => Product.fromJson(obj))
            .toList();
        notifyListeners();
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.code.toString()=="500")
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>NoConcation())
        );
      }
    }
  }

  deleteproduct(context,params)async{
    try{
      await ApiHandler.post(UrlResources.DELETEPRODUCT,body: params).then((json){
        if(json["status"]=="true")
        {
          isdelete = true;
        }
        else{
          isdelete = false;
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      if (ex.code.toString()==500)
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>NoConcation())
        );
      }
    }
  }

  updaetproduct(context,params)async{
    try{

      await ApiHandler.post(UrlResources.UPDATEPRODUCT,body: params).then((json){
        if(json["status"]=="true")
        {
          isupdted = true;
        }
        else{
          isupdted = false;
        }
      });



    }
    on ErrorHandler catch (ex)
    {
      if (ex.code.toString()==500)
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>NoConcation())
        );
      }
    }
  }


  Product obj;

  getsinglerecord(context,pid) async
  {
    try{
      await ApiHandler.post(UrlResources.GETSINGLEPRODUCT,body: {"pid":pid}).then((json){
        obj = Product.fromJson(json["data"]);
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.code.toString()=="500")
      {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>NoConcation())
        );
      }
    }
  }

}