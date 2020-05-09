import 'package:flutter/material.dart';
import 'package:gdziemojhajsapp/pages/Category.dart';


class CategoryCard extends StatelessWidget {

  final Category category;
  CategoryCard({this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage(category.image),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      category.name,
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
                        Navigator.pushNamed(context, '/category', arguments: {
                          'name': category.name,
                          'description': category.description,
                          'spent': category.spent
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
                SizedBox(height: 6.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


