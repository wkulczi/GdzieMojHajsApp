import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdziemojhajsapp/logic/Constants/colors.dart';
import 'package:gdziemojhajsapp/logic/Controllers/receipt_controller.dart';
import 'package:gdziemojhajsapp/logic/Models/product_model.dart';
import 'package:gdziemojhajsapp/logic/Models/receipt_model.dart';

class CreateReceipt extends StatefulWidget {
  static String tag = "/edit-receipt";
  final ReceiptModel receipt;

  const CreateReceipt({Key key, this.receipt}) : super(key: key);

  @override
  _CreateReceiptState createState() => _CreateReceiptState(this.receipt);
}

class _CreateReceiptState extends State<CreateReceipt> {
  final _formKey = GlobalKey<FormState>();
  ReceiptModel _receipt;
  bool isNewReceipt = true;

  _CreateReceiptState(receipt) {
    if (receipt != null) {
      this._receipt = receipt;
      this.isNewReceipt = false;
    } else {
      this._receipt = ReceiptModel(sum: 0.0, categoryName: null, products: [], companyName: null);
    }
  }

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
                actions: <Widget>[
                  Visibility(
                    visible: !isNewReceipt,
                    child: InkWell(
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Icon(Icons.delete_outline)),
                      onTap: () async {
                        //tutaj jakaś wiksa będzie z dodawaniem kasy do limitu z kategorii, SZTOS
                        await ReceiptController.deleteReceipt(_receipt.id).then((value) async => {
                              if (value == 200)
                                {
                                  await Navigator.of(context).pop(),
                                  //todo
                                  showSuccessFlushbar(context, sum: "TODO"),
                                }
                              else
                                {
                                  showFailureFlushbar(context),
                                }
                            });

//                      TODO -> SEND REMOVE
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(isNewReceipt ? "New receipt" : "Edit receipt"),
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
                                  formFieldWidget(this._receipt.companyName, "Shop name",
                                      (input) => this._receipt.companyName = input, TextInputType.text),
                                  formFieldWidget(this._receipt.categoryName, "Category",
                                      (input) => this._receipt.categoryName = input, TextInputType.text),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: this._receipt.products.length,
                                    itemBuilder: (cntxt, index) {
                                      return productWidget(index);
                                    },
                                  ),
                                  FlatButton(
                                    onPressed: () => {
                                      this._receipt.products.add(ProductModel()),
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
                                        isNewReceipt ? Icon(Icons.save) : Icon(Icons.arrow_upward),
                                        Text((isNewReceipt ? "Save receipt" : "Update receipt")),
                                      ],
                                    ),
                                    //todo isempty? this : update
                                    onPressed: () async => {
                                      if (isNewReceipt)
                                        {
                                          if (_formKey.currentState.validate())
                                            {
                                              ReceiptController.sendReceipt(receipt: this._receipt).then(
                                                (value) async => {
                                                  if (value.statusCode == 200)
                                                    {
                                                      await Navigator.of(context).pop(),
                                                      showSuccessFlushbar(context, sum: this._receipt.sum.toString()),
                                                    }
                                                  else
                                                    {showFailureFlushbar(context)}
                                                },
                                              )
                                            }
                                        }
                                      else
                                        {
                                          if (this._receipt.products.length == 0)
                                            {print(this._receipt.products.length), showFailureFlushbar(context)},
                                          if (_formKey.currentState.validate() && this._receipt.products.length > 0)
                                            {
                                              //if receipt.products.length==0 -> flushbar
                                              //todo jak zrobię moduł rafała to dopiero wtedy mogę robić to
                                              await ReceiptController.updateReceipt(receipt: this._receipt).then(
                                                  (value) async => {
                                                        await Navigator.of(context).pop(),
                                                        showSuccessFlushbar(context, sum: "JESTEM CZAJNIKIEM, DUT DUT")
                                                      })
                                            }
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
    this._receipt.sum = 0;
    for (ProductModel product in this._receipt.products) {
      if (product.price != null && product.quantity != null) {
        this._receipt.sum += product.price * product.quantity;
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
                  this._receipt.sum.toString() == 'null' ? "0.00 PLN" : this._receipt.sum.toString() + " PLN",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  formFieldWidget(value, String labelText, Function(dynamic) _onChanged, TextInputType _keyboardType) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 55,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: TextFormField(
            //todo
            //insert optional init value of 1 for quantity
            initialValue: value,
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
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(50)), //back at it again with clever hacks
                  child: Icon(Icons.remove),
                ),
                onTap: () {
                  this._receipt.products.removeAt(index);
                  setState(() {});
                },
              ),
            ),
            formFieldWidget(this._receipt.products[index].name, "Name",
                (input) => {print(input), this._receipt.products[index].name = input}, TextInputType.text),
            formFieldWidget(
                this._receipt.products[index].price == null
                    ? this._receipt.products[index].price
                    : this._receipt.products[index].price.toString(),
                "Price",
                (input) => {this._receipt.products[index].price = double.parse(input), setState(() {})},
                TextInputType.number),
            formFieldWidget(
                this._receipt.products[index].quantity == null
                    ? this._receipt.products[index].quantity
                    : this._receipt.products[index].quantity.toString(),
                "Qty",
                (input) => {this._receipt.products[index].quantity = int.parse(input), setState(() {})},
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
        isNewReceipt ? "Error sending receipt" : "Error updating receipt",
        style: TextStyle(color: Colors.red),
      ),
      messageText: Text(
        "Try again later",
        style: TextStyle(color: Colors.black),
      ),
    )..show(context);
  }

  showSuccessFlushbar(BuildContext context, {String sum = '0'}) {
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
        isNewReceipt ? "Receipt sent" : "Receipt updated",
        style: TextStyle(color: Colors.green),
      ),
      messageText: Text(
        "$sum PLN" + (isNewReceipt ? " removed from limits" : " returned to limits"),
        style: TextStyle(color: Colors.black),
      ),
    )..show(context);
  }
}
