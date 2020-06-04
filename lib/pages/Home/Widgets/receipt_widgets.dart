import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:gdziemojhajsapp/logic/Constants/receipts_icons_map.dart';
import 'package:gdziemojhajsapp/logic/Controllers/receipt_controller.dart';
import 'package:gdziemojhajsapp/logic/Entities/receipt.dart';
import 'package:gdziemojhajsapp/pages/Home/Widgets/sort_receipts_bar.dart';
import 'package:gdziemojhajsapp/pages/Receipt/createReceipt.dart';

class ReceiptList extends StatefulWidget {
  bool _isCollapsed;

  ReceiptList(isCollapsed) {
    this._isCollapsed = isCollapsed;
  }

  @override
  _ReceiptListState createState() => _ReceiptListState(this._isCollapsed);
}

class _ReceiptListState extends State<ReceiptList> {
  bool _isCollapsed;

  _ReceiptListState(isCollapsed) {
    this._isCollapsed = isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReceiptController.getAccountsReceipts(),
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
                  return NotEmptyReceiptList(isCollapsed: _isCollapsed, snapshot: snapshot, scrollController: scrollController);
                } else {
                  return noReceiptsWidget(scrollController: scrollController);
                }
              });
        });
  }
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
                Icon(Icons.info_outline, color: Colors.blue, size: ScreenUtil().setSp(100)),
                Text("Brak paragonów 🤷‍♂️", style: TextStyle(fontSize: ScreenUtil().setSp(50)))
              ],
            ),
          )))
    ]),
  );
}

Widget loadingWidget({scrollController}) {
  return Container(color: Colors.white, child: ListView(controller: scrollController, children: [Center(child: CircularProgressIndicator())]));
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

Widget receiptCard({isCollapsed, context, receipt}) {
  return Card(
    child: ListTile(
      enabled: isCollapsed,
      onTap: () async {
        var payload = await ReceiptController.getReceiptById(receipt.id);
        print(payload.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateReceipt(receipt: payload)));
      },
      leading: CircleAvatar(
        child: Icon(receipt_icons[receipt.categoryName.toString()], size: 32),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      subtitle: Text(
        receipt.categoryName,
        style: TextStyle(fontSize: 12),
      ),
      title: Text(receipt.companyName),
      trailing: Text(receipt.sum.toStringAsFixed(2) + " PLN"),
    ),
  );
}

class NotEmptyReceiptList extends StatefulWidget {
  final bool isCollapsed;

  final snapshot;

  final ScrollController scrollController;

  NotEmptyReceiptList({this.isCollapsed, this.snapshot, this.scrollController});

  @override
  _NotEmptyReceiptListState createState() => _NotEmptyReceiptListState(isCollapsed: this.isCollapsed, snapshot: this.snapshot, scrollController: this.scrollController);
}

class _NotEmptyReceiptListState extends State<NotEmptyReceiptList> {
  final bool isCollapsed;
  final snapshot;
  final ScrollController scrollController;

  TextEditingController receiptTextController = TextEditingController();

  _NotEmptyReceiptListState({this.isCollapsed, this.snapshot, this.scrollController});

  List<Receipt> sortedReceiptList;
  List<Receipt> filteredReceiptList;
  Function sortList;
  Function filterList;

  @override
  void initState() {
    this.sortedReceiptList = ReceiptController.sortReceipts(snapshot.data, SortReceiptsBar.selectedReceiptsSortType, SortReceiptsBar.isIncreasing);
    this.filteredReceiptList = this.sortedReceiptList;

    this.filterList = (String value) {
      if (value.isEmpty) {
        setState(() {
          this.filteredReceiptList = this.sortedReceiptList;
        });
      } else {
        setState(() {
          this.filteredReceiptList = this.sortedReceiptList.where((receipt) => (receipt.companyName.toLowerCase().contains(value.toLowerCase()))).toList();
        });
      }
    };
    this.sortList = () {
      this.filteredReceiptList = ReceiptController.sortReceipts(snapshot.data, SortReceiptsBar.selectedReceiptsSortType, SortReceiptsBar.isIncreasing);
      setState(() {});
    };
  } //  List <Receipt> sortedData = snapshot.data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
                children: <Widget>[SizedBox(height: 40)] +
                    filteredReceiptList.map<Widget>((Receipt receipt) {
                      return receiptCard(isCollapsed: isCollapsed, context: context, receipt: receipt);
                    }).toList()),
          ),
          SortReceiptsBar(
            filterList: this.filterList,
            sortList: this.sortList,
            textController: this.receiptTextController,
          )
        ],
      ),
    );
  }
}
