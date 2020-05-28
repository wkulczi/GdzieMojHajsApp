import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Controllers/receipt_controller.dart';
import 'package:gdziemojhajsapp/logic/Entities/receipt.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/dashboard_menu.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';

import '../home_screen.dart';

Widget receiptList() {
  return FutureBuilder(
      future: ReceiptController.getAccountsReceipts(),
      builder: (context, snapshot) {
        return DraggableScrollableSheet(
            expand: true,
            initialChildSize: 1,
            minChildSize: 0.7,
            builder: (context, scrollController) {
              if (snapshot.hasError) {
                return receiptErrorWidget(
                    snapshot: snapshot, scrollController: scrollController);
              } else if (ConnectionState.waiting == snapshot.connectionState) {
                return loadingWidget(scrollController: scrollController);
              } else if (ConnectionState.done == snapshot.connectionState &&
                  snapshot.hasData) {
                return receiptListWidget(
                    context: context,
                    snapshot: snapshot,
                    scrollController: scrollController);
              } else {
                return noReceiptsWidget(scrollController: scrollController);
              }
            });
      });
}

Widget noReceiptsWidget({scrollController}) {
  return Container(
    color: Colors.white,
    child: ListView(controller: scrollController, children: [
      Container(
          color: Colors.white,
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(Icons.info_outline,
                    color: Colors.blue, size: ScreenUtil().setSp(100)),
                Text("Brak paragonów 🤷‍♂️",
                    style: TextStyle(fontSize: ScreenUtil().setSp(50)))
              ],
            ),
          )))
    ]),
  );
}

Widget receiptListWidget({isCollapsed, context, snapshot, scrollController}) {
  return Container(
    color: Colors.white,
    child: Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Column(
              children: <Widget>[SizedBox(height: 40)] +
                  snapshot.data.map<Widget>((Receipt receipt) {
                    return receiptCard(context: context, receipt: receipt);
                  }).toList()),
        ),
        SortReceiptsBar()
      ],
    ),
  );
}

Widget loadingWidget({scrollController}) {
  return Container(
      color: Colors.white,
      child: ListView(
          controller: scrollController,
          children: [Center(child: CircularProgressIndicator())]));
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

Widget receiptCard({context, receipt}) {
  return Card(
    child: ListTile(
      onTap: () async {
        var payload = await ReceiptController.getReceiptById(receipt.id);
        print(payload.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateReceipt(receipt: payload)));
      },
      leading: FlutterLogo(), //category logo
      title: Text(receipt.companyName),
      trailing: Text(receipt.sum.toStringAsFixed(2) + " PLN"),
    ),
  );
}
