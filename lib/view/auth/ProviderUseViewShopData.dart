import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ShopingApi/ViewDataProviderUse.dart';
import '../../provider/ShopingProvider.dart';


class other extends StatefulWidget {

  @override
  State<other> createState() => _otherState();
}

class _otherState extends State<other> {


  ShoppingProvider provider;
  List<Shopping> alldata;
//with provider view data

  getProduct()async{
    await provider.getdata(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ShoppingProvider>(context,listen: false);
    getProduct();
  }

  @override
  Widget build(BuildContext context) {

    provider = Provider.of<ShoppingProvider>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("View Data"),
      ),
      body: (provider.allproducts!=null)?ListView.builder(
        itemCount: provider.allproducts.length,
        itemBuilder: (context,index){
          return Container(
            child: Column(
              children: [
                Text(provider.allproducts[index].title.toString()),
                Image.network(provider.allproducts[index].image)              ],
            ),
          );
        },
      ):Center(child: CircularProgressIndicator()),
    );
  }
}
