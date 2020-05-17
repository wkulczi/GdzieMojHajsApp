import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/logic/Controllers/receipt_controller.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';
import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';

class AddReceipt extends StatefulWidget {
  static var tag = "/newReceipt";

  @override
  _AddReceiptState createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  ReceiptController _receiptController = ReceiptController();
  final _formKey = GlobalKey<FormState>();
  ReceiptModel _receipt = ReceiptModel(sum: 0.0, categoryName: null, products: [], companyName: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          color: ColorStyles.hexToColor("#F8F8FF"),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 150,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
//                titlePadding: EdgeInsets.only(bottom: 30),
                  title: Text("New receipt"),
                ),
                backgroundColor: Colors.transparent,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: SafeArea(
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: <Widget>[
                                  formFieldWidget(
                                      "Shop name", (input) => _receipt.companyName = input, TextInputType.text),
                                  formFieldWidget(
                                      "Category", (input) => _receipt.categoryName = input, TextInputType.text),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _receipt.products.length,
                                    itemBuilder: (cntxt, index) {
                                      return productWidget(index);
                                    },
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      _receipt.products.add(ProductModel()),
                                      setState(() {}),
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.add),
                                        Text("Add product"),
                                      ],
                                    ),
                                  ),
                                  sumWidget(),
                                  FlatButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Icon(Icons.save),
                                        Text("Save receipt"),
                                      ],
                                    ),
                                    onPressed: () async => {
                                      if (_formKey.currentState.validate())
                                        {
                                          _receiptController.sendReceipt(receipt: _receipt).then(
                                                (value) async => {
                                                  if (value.statusCode == 200)
                                                    {
                                                      await Navigator.of(context).pop(),
                                                      showSuccessFlushbar(context, _receipt.sum.toString()),
                                                    }
                                                  else{
                                                    showFailureFlushbar(context)
                                                  }
                                                },
                                              )
                                        }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  sumWidget() {
    _receipt.sum = 0;
    for (ProductModel product in _receipt.products) {
      if (product.price != null && product.quantity != null) {
        _receipt.sum += product.price * product.quantity;
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text("Price:"),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _receipt.sum.toString() == 'null' ? "0.00 PLN" : _receipt.sum.toString() + " PLN",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  formFieldWidget(String labelText, Function(dynamic) _onChanged, TextInputType _keyboardType) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 55,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: TextFormField(
            //todo
            //insert optional init value of 1 for quantity
            keyboardType: _keyboardType,
            decoration: InputDecoration(
              errorMaxLines: 1,
              errorStyle: TextStyle(height: 0, fontSize: 12),
              labelText: labelText,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a value here.';
              }
              return null;
            },
            onChanged: _onChanged,
          ),
        ),
      ),
    );
  }

  Widget productWidget(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 1),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorStyles.hexToColor("#f0eded"),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            formFieldWidget(
                "Name", (input) => {print(input), _receipt.products[index].name = input}, TextInputType.text),
            formFieldWidget("Price", (input) => {_receipt.products[index].price = double.parse(input), setState(() {})},
                TextInputType.number),
            formFieldWidget("Qty", (input) => {_receipt.products[index].quantity = int.parse(input), setState(() {})},
                TextInputType.number),
          ],
        ),
      ),
    );
  }

  showFailureFlushbar(BuildContext context) {
    Flushbar(
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      //todo customise if ya want
      backgroundColor: ColorStyles.hexToColor("#FEFEFE"),
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
      ],
      duration: Duration(seconds: 3),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      titleText: Text(
        "Error sending receipt",
        style: TextStyle(color: Colors.red),
      ),
      messageText: Text(
        "Try again later",
        style: TextStyle(color: Colors.black),
      ),
    )..show(context);
  }

  showSuccessFlushbar(BuildContext context, String sum) {
    Flushbar(
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      //todo customise if ya want
      backgroundColor: ColorStyles.hexToColor("#FEFEFE"),
      boxShadows: [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
      ],
      duration: Duration(seconds: 3),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      titleText: Text(
        "Receipt sent",
        style: TextStyle(color: Colors.green),
      ),
      messageText: Text(
        "$sum PLN removed from limits",
        style: TextStyle(color: Colors.black),
      ),
    )..show(context);
  }
}
