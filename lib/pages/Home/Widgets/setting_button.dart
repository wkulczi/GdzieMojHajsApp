import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

Widget settingButtonWidget({icon, settingTitle, onTap}) {
  return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12)),
        child: InkWell(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                child: Icon(
                  icon,
                  size: 18,
                ),
              ),
              Text(
                settingTitle,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          onTap: onTap,
        ),
      ));
}

