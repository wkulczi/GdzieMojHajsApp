import 'package:flutter/material.dart';
import 'package:gmh_app/Constants/colors.dart';
import 'package:gmh_app/Models/receipt_model.dart';

import 'Home/Widgets/default_gradient_decoration.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final _formKey = GlobalKey<FormState>();
  List<String> testList = ["one"];
  ReceiptModel _receipt =
      ReceiptModel(sum: null, categoryName: null, products: [], shopName: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FlatButton(
        color: Colors.white,
        onPressed: () => {
          print("nic sie nie dzieje, fuck off"),
          testList.add("1"),
          setState(() {}),
        },
        child: Text("Guzik do niczego"),
      ),
      body: Container(
        decoration: defaultGradientDecoration(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.only(bottom: 30),
                title: Text("TESTVIEW."),
              ),
              backgroundColor: Colors.transparent,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorStyles.hexToColor("#FEFEFE"),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: SafeArea(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: testList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    color: Colors.red,
                                    height: 20,
                                    child: Text(testList[index]));
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  formFieldWidget(String labelText, Function(dynamic) _onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 55,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
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
}
