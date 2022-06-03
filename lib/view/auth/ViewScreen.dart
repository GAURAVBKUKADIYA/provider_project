import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../ShopingApi/ViewDataProviderUse.dart';
import '../../helper/AuthHelper.dart';
import '../Product/AddProduct.dart';
import '../Product/ViewProduct.dart';
import 'LoginScreen.dart';

class ViewScreen extends StatefulWidget {


  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  var name="";
  getdata()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name  = prefs.getString("name").toString();

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("View"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName:Text("welcome:- "+name),
                currentAccountPicture:CircleAvatar(
                  child: Text(name[0].toString().toUpperCase()),
                )
            ),

            ListTile(
              onTap: ()async{
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AddProduct())
                );
              },
              leading: Icon(Icons.add),
              title: Text("AddProduct",style: TextStyle(fontSize: 18),),
              trailing: Icon(Icons.arrow_forward_outlined,color: Colors.blue,),
            ),
            ListTile(

              onTap: ()async{
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ViewProduct())
                );
              },

              leading: Icon(Icons.add),
              title: Text("ViewProduct",style: TextStyle(fontSize: 18),),
              trailing: Icon(Icons.arrow_forward_outlined,color: Colors.blue,),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("AddEmployed",style: TextStyle(fontSize: 18),),
              trailing: Icon(Icons.arrow_forward_outlined,color: Colors.blue,),
            ), ListTile(
              leading: Icon(Icons.add),
              title: Text("ViewEmployed",style: TextStyle(fontSize: 18),),
              trailing: Icon(Icons.arrow_forward_outlined,color: Colors.blue,),
            ),
            ListTile(
              onTap: ()async{

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>Shopping())
                );
              },


              leading: Icon(Icons.add),
              title: Text("Shpping",style: TextStyle(fontSize: 18),),
              trailing: Icon(Icons.arrow_forward_outlined,color: Colors.blue,),
            ),

            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // prefs.clear();
              AuthHelper.clearAll();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>LoginScreen())
              );
            },

                child:Text("Logout"))

          ],
        ),
      ),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
