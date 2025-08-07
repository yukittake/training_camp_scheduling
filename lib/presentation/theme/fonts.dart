import 'package:flutter/material.dart';
class AppFont{
  static const general ='NotoSansJP';
}
class AppText{
  static const title = TextStyle(
    fontSize:36,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w700
  );
  // static const normal = TextStyle(
  //   fontSize:18,
  //   fontFamily: AppFont.general,
  //   fontWeight: FontWeight.w400
  // );
}