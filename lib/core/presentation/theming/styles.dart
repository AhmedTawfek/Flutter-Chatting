
import 'package:chatting/core/presentation/theming/color_manager.dart';
import 'package:flutter/material.dart';

class TextStyles{

  static TextStyle p14Regular = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal
  );

  static TextStyle heading1 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: ColorManager.black,
    );

  static TextStyle heading2 = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: ColorManager.black,
    );

  static TextStyle heading3 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  static TextStyle heading4 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  static TextStyle heading5 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: ColorManager.black,
  );

  // Subtitle styles
  static TextStyle subtitle1 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: ColorManager.grey,
    );

  static TextStyle subtitle2 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorManager.grey,
    );

}