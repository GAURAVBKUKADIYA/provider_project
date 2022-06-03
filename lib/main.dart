import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:provider_project/provider/AuthProvider.dart';
import 'package:provider_project/provider/ShopingProvider.dart';
import 'package:provider_project/provider/productProvider.dart';
import 'package:provider_project/view/SplachScreen.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create:(context)=> AuthProvider()),
        ChangeNotifierProvider(create: (context)=>ShoppingProvider()),
        ChangeNotifierProvider(create: (context)=>ProductProvider())

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

