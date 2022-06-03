import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/provider/productProvider.dart';
import 'package:provider_project/resourses/StringResourses.dart';
import 'package:provider_project/resourses/StyaleResourse.dart';
import 'package:provider_project/widgets/MyPrimaryButton.dart';

import '../../widgets/MyTextBox.dart';

class UpdateProduct extends StatefulWidget {


  var udateid="";
  UpdateProduct({this.udateid});

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  Widget _productform()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _name,
          ispassword: false,
          keyboard: TextInputType.text,
        ),
        SizedBox(height: 10,),
        Text("Quantity",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _qty,
          ispassword: false,
          keyboard: TextInputType.text,
        ),
        SizedBox(height: 10,),
        Text("Price",style: StyaleResources.primaryTextstyle,),
        SizedBox(height: 10,),
        MyTextBox(
          controller: _price,
          ispassword: false,
          keyboard: TextInputType.text,
        ),
      ],
    );
  }
  Widget _updateclick()
  {
    return MyPrimaryButton(
      buttonText: "Update",

      onclick: ()async{

        var name = _name.text.toString();
        var qty = _qty.text.toString();
        var price = _price.text.toString();

        Map<String,String> params = {
          "pname":name,
          "qty":qty,
          "price":price,
          "pid":widget.udateid
        };

        await provider.updaetproduct(context, params);
        if(provider.isupdted)
          {
            await provider.viewproduct(context);
            Navigator.of(context).pop();
          }

      },

    );
  }


  ProductProvider provider;

  getdata() async
  {
    await provider.getsinglerecord(context, widget.udateid);
    _name.text = provider.obj.pname.toString();
    _qty.text = provider.obj.qty.toString();
    _price.text = provider.obj.price.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ProductProvider>(context,listen: false);
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UpdateYourProduct"),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _productform(),
              SizedBox(height: 15,),
              _updateclick()

            ],
          ),
        ),
      ),
    );
  }
}
