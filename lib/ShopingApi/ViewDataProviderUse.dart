import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ShopingProvider.dart';
import 'models/shopingModel.dart';


class Shopping extends StatefulWidget {
  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {

  ShoppingProvider provider;
  List<ShopingUser> alldata;

  Map<String,String> params={
    "name":"ABC"
  };

  getproduct()async{
    await provider.getdata(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ShoppingProvider>(context,listen: false);
    getproduct();
  }


  String selectedProduct;



  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ShoppingProvider>(context,listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Api"),
      ),
      body:  (provider.allproducts!=null)?
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: new Text("Select Region"),
                        value: selectedProduct,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            selectedProduct = newValue;
                          });
                        },
                        items: provider.allproducts.map((e){

                          //get data in dropdown

                          return DropdownMenuItem(
                            child: SizedBox(width: 300.0,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.title.toString()),
                            )),
                            value: e.id.toString(),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
          :Center(child: CircularProgressIndicator()),
      // body: (provider.allproducts!=null)?SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         child: Column(
      //           children: provider.allproducts.map((obj){
      //             return Container(
      //               child: Column(
      //                 children: [
      //                   Text(obj.title.toString()),
      //                   Text(obj.image.toString())
      //                 ],
      //               ),
      //             );
      //           }).toList(),
      //         ),
      //       )
      //     ],
      //   ),
      // ):Center(child: CircularProgressIndicator()),
      // body: (provider.allproducts!=null)?
      //     ListView.builder(
      //       itemCount: provider.allproducts.length,
      //       itemBuilder: (context,index)
      //       {
      //         return ListTile(
      //           title: Text(provider.allproducts[index].title),
      //         );
      //       },
      //     )
      //     :Center(child: CircularProgressIndicator()),
    );
  }
}
