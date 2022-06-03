import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ShopingApi/models/shopingModel.dart';
import '../Utility/ApiHandler.dart';
import '../Utility/ErrorHandler.dart';
import '../resourses/UrlResourses.dart';
import '../view/Conaction/NoInterNetConaction.dart';

class ShoppingProvider extends ChangeNotifier{


  List<ShopingUser> allproducts;

  getdata(context)async{
    try{
      await ApiHandler.get(UrlResources.SHOPPING).then((json){
        print(json);
        allproducts = json.map<ShopingUser>((obj)=>ShopingUser.fromJson(obj)).toList();
        notifyListeners();
      });
    }
    on  ErrorHandler catch (ex)
    {
      if(ex.code.toString()=="500")
      {
        Navigator.of(context).push(
          MaterialPageRoute(builder:(context)=>NoConcation()),
        );
      }
    }

  }

}