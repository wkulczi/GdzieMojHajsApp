import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/logic/receipt_logics.dart';

class ReceiptLayout extends StatelessWidget {
  String companyName;
  String sum;

  ReceiptLayout(String companyName, String sum) {
    this.companyName = companyName;
    this.sum = sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(), //category logo
        title: Text(this.companyName),
        trailing: Text(sum + " PLN"),
      ),
    );
  }
}

class ReceiptsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
      future: getUserReceiptsOverview(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Map> data = snapshot.data;
          return _receiptsListViewBuilder(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        else{
          return Text("You have no receipts!");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

ListView _receiptsListViewBuilder(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ReceiptLayout(data[index]["companyName"], data[index]["sum"]);
      });
}
