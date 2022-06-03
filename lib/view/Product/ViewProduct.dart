import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/productProvider.dart';
import '../../resourses/StyaleResourse.dart';
import 'UpdateProductProvider.dart';

class ViewProduct extends StatefulWidget {


  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {

  ProductProvider provider;

  getproduct()async{

    await provider.viewproduct(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ProductProvider>(context,listen: false);
    getproduct();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProductProvider>(context,listen: true);
    return Scaffold(
      body: (provider.alldata != null)?
      ListView.builder(
        itemCount: provider.alldata.length,
        itemBuilder: (context,index){
          return Container(
              margin: EdgeInsets.all(10), padding: EdgeInsets.all(5),
              decoration:StyaleResources.primaryContainerdecoration,


              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider.alldata[index].pname,style: StyaleResources.primaryTextstyle,),
                  Text(provider.alldata[index].qty,style: StyaleResources.primaryTextstyle,),
                  Text("Rs:- "+provider.alldata[index].price,style: StyaleResources.primaryTextstyle,),
                  SizedBox(height: 10,),
                  Text(provider.alldata[index].addedDatetime),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: ()async{




                        AlertDialog alert = AlertDialog(
                          title: Text("Are You Sure",style: TextStyle(fontSize: 18,color: Colors.red),),
                          content: Text("This Product has delete"),
                          actions: [
                            ElevatedButton(onPressed: ()async{
                              Map<String,String> params = {
                                "pid":provider.alldata[index].pid.toString(),
                              };
                              await provider.deleteproduct(context, params);
                              if(provider.isdelete==true)
                              {
                                Fluttertoast.showToast(
                                    msg:"Delete Sucsees",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).pop();
                                await provider.viewproduct(context);
                              }
                            },

                                child:Text("Yes")),



                            ElevatedButton(onPressed: ()async{

                              Navigator.of(context).pop();
                            },
                                child:Text("No")),

                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                      },
                          child:Text("Delete")),


                      ElevatedButton(onPressed: ()async{

                        //pidpass

                        var pid = provider.alldata[index].pid.toString();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>UpdateProduct(udateid: pid,))
                        );

                      },
                          child:Text("Update")),
                    ],
                  )
                ],
              )
          );
        },
      ): Center(child: CircularProgressIndicator()),
    );
  }
}
