import 'package:flutter/material.dart';
import 'package:training_camp_scheduling/presentation/theme/colors.dart';
class AppFont{
  static const general ='NotoSansJP';
}
class AppText{
  static const title = TextStyle(
    fontSize:36,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w700
  );
  static const subTitle = TextStyle(
    fontSize:20,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w700
  );
  static const normal = TextStyle(
    fontSize:18,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
    decoration: TextDecoration.none,
  );
  static const smaller = TextStyle(
    fontSize:14,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w400
  );
  static const annotation = TextStyle(
    fontSize:18,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w400,
    color: AppColor.greyWidgetLine
  );
  static const formAnnotation = TextStyle(
    fontSize:14,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w400,
    color: AppColor.greySubString
  );
  static const delete = TextStyle(
    fontSize: 13,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w400,
    color:AppColor.red,
    decoration: TextDecoration.none,
  );
  static const smallWhite = TextStyle(
    fontSize: 13,
    fontFamily: AppFont.general,
    fontWeight: FontWeight.w400,
    color: AppColor.white
  );
}