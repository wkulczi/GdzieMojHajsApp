import 'package:flutter/material.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:flutter_translate/localized_app.dart';
import 'package:gdziemojhajsapp/logic/Entities/Category.dart';
import 'package:gdziemojhajsapp/pages/Categories/categoryPage.dart';

class CategoryCard extends StatefulWidget {

  final Category category;
  CategoryCard({this.category});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  String string="pl";

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    getActualLocale(localizationDelegate);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      borderOnForeground: false,
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          image: DecorationImage(
            image: AssetImage(widget.category.image),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        string=="pl"?widget.category.name:widget.category.name_eng,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, CategoryPage.tag,
                              arguments: {
                                'name': widget.category.name,
                                'eng': widget.category.name_eng,
                                'description': widget.category.description,
                                'spent': widget.category.spent,
                                'limit': widget.category.limit
                              });
                        },
                        icon: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 1.0,
                              top: 3.0,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                                size: 36,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 37,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getActualLocale(LocalizationDelegate localizationDelegate) async {
    var locale;
    await localizationDelegate.preferences.getPreferredLocale().then((value) => locale = value.toString());
    setState(() {
      string = locale;
    });
  }
}
