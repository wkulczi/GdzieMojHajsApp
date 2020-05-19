import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Controllers/receipt_controller.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';

Widget receiptList() {
  return FutureBuilder(
      future: ReceiptController.getAllAccountsReceipts(),
      builder: (context, snapshot) {
        return DraggableScrollableSheet(
            expand: true,
            initialChildSize: 1,
            minChildSize: 0.7,
            builder: (context, scrollController) {
              if (snapshot.hasError) {
                return receiptErrorWidget(snapshot: snapshot, scrollController: scrollController);
              } else if (ConnectionState.waiting == snapshot.connectionState) {
                return loadingWidget(scrollController: scrollController);
              } else if (ConnectionState.done == snapshot.connectionState && snapshot.hasData) {
                return receiptListWidget(context: context, snapshot: snapshot, scrollController: scrollController);
              } else {
                return noReceiptsWidget(scrollController: scrollController);
              }
            });
      });
}

Widget noReceiptsWidget({scrollController}) {
  return Container(color:Colors.white,
    child: ListView(controller: scrollController, children: [
      Container(
          color: Colors.white,
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.info_outline, color: Colors.blue, size: ScreenUtil().setSp(100)),
                Text("Brak paragonów 🤷‍♂️", style: TextStyle(fontSize: ScreenUtil().setSp(50)))
              ],
            ),
          )))
    ]),
  );
}

Widget receiptListWidget({context, snapshot, scrollController}) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      controller: scrollController,
      child: Column(
          children: snapshot.data.map<Widget>((Map data) {
        return receiptCard(context: context, id: data["id"], companyName: data["companyName"], sum: data["sum"]);
      }).toList()),
    ),
  );
}

Widget loadingWidget({scrollController}) {
  return Container(
      color: Colors.white,
      child: ListView(controller: scrollController, children: [Center(child: CircularProgressIndicator())]));
}

Widget receiptErrorWidget({snapshot, scrollController}) {
  return Container(
    color: Colors.white,
    child: ListView(controller: scrollController, children: [
      Center(
          child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: ScreenUtil().setSp(100),
            ),
            Text(
              snapshot.error.toString(),
              style: TextStyle(fontSize: ScreenUtil().setSp(50)),
            ),
          ],
        ),
      ))
    ]),
  );
}

Widget receiptCard({context, id, companyName, sum}) {
  return Card(
    child: ListTile(
      onTap: () async {
        var payload = await ReceiptController.getReceiptById(id);
        print(payload.id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateReceipt(receipt: payload)));
      },
      leading: FlutterLogo(), //category logo
      title: Text(companyName),
      trailing: Text(sum + " PLN"),
    ),
  );
}
