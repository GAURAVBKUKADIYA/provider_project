import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/LoginScreen.dart';
import 'auth/ViewScreen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  gotoapp()async{

    await  Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ViewScreen())
      );
    }
    else{
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>LoginScreen())
      );
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gotoapp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Image.asset("img/welcome.jpg"),
                SizedBox(height: 20,),
                CircularProgressIndicator(),
              ],
            ),
          )
        ],
      ),
      ),
    );
  }
}
