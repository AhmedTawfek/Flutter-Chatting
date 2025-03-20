
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles{

  static TextStyle p14Regular = TextStyle(
    fontSize: 12.sp,
      fontFamily: 'Roboto',
    fontWeight: FontWeight.normal
  );

  static TextStyle heading1 = TextStyle(
      fontSize: 24.sp,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: ColorManager.black,
    );

  static TextStyle heading2 = TextStyle(
      fontSize: 22.sp,
    fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: ColorManager.black,
    );

  static TextStyle heading3 = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  static TextStyle heading4 = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  static TextStyle heading5 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  static TextStyle heading6 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  // Subtitle styles
  static TextStyle subtitle1 = TextStyle(
      fontSize: 18.sp,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: ColorManager.grey,
    );

  static TextStyle subtitle2 = TextStyle(
      fontSize: 16.sp,
    fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: ColorManager.grey,
    );

  static TextStyle subtitle3 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.grey,
  );

  static TextStyle subtitle4 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.grey,
  );

  static TextStyle subtitle5 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.grey,
  );

}