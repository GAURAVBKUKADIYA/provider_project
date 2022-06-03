import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/productProvider.dart';
import '../../resourses/StyaleResourse.dart';
import '../../widgets/MyPrimaryButton.dart';
import '../../widgets/MyTextBox.dart';

class AddProduct extends StatefulWidget {


  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();



  Widget _loginform(){
    return

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name",style:StyaleResources.primaryTextstyle,),
          SizedBox(height: 10,),
          MyTextBox(
            controller: _name,
            ispassword: false,
            hinttext: "ProductName",
            keyboard: TextInputType.text,
          ),
          Text("Quantity",style:StyaleResources.primaryTextstyle,),
          SizedBox(height: 10,),
          MyTextBox(
            controller: _qty,
            ispassword: false,
            hinttext: "Quantity",
            keyboard: TextInputType.number,
          ),
          Text("Price",style:StyaleResources.primaryTextstyle,),
          SizedBox(height: 10,),
          MyTextBox(
            controller: _price,
            ispassword: false,
            hinttext: "type123",
            keyboard: TextInputType.number,
          ),
        ],
      );
  }

  Widget _addclick()
  {
    return MyPrimaryButton(
      onclick: ()async{
        var name = _name.text.toString();
        var qty = _qty.text.toString();
        var price = _price.text.toString();

        Map<String,String> params = {
          "pname":name,
          "qty":qty,
          "price":price
        };

        await provider.addproduct(context,params);

        if(provider.isinserted)
        {
          Fluttertoast.showToast(
              msg: "AddProductSucsessfuly",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          _name.text="";
          _qty.text="";
          _price.text="";
        }
        else
        {
          Fluttertoast.showToast(
              msg: "Somthing Wrong",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }



      },
      buttonText: "Add",
    );
  }

  ProductProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = Provider.of<ProductProvider>(context,listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddProduct"),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child:Column(
                children: [
                  _loginform(),
                  SizedBox(height: 20,),
                  _addclick()
                ],
              )
          )
      ),
    );
  }
}
