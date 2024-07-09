import 'package:flutter/material.dart';

const Color kBabyBlue = Color(0xFFBBE7FE);
const Color kLilac = Color(0xFFD3B5E5);
const Color kRoseQuartz = Color(0xFFFFD4DB);
const Color kCream = Color(0xFFEFF1DB);

const TextStyle kAppTitle = TextStyle(
  fontSize: 26,
  fontFamily: 'Playfair Display',
  fontWeight: FontWeight.bold,
);

const TextStyle kContentTextStyle = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.normal,
);

TextStyle textStyleWith({
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontFamily: kContentTextStyle.fontFamily,
    fontSize: fontSize ?? kContentTextStyle.fontSize,
    fontWeight: fontWeight ?? kContentTextStyle.fontWeight,
  );
}
