import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.lightBlue,
  backgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'proxima',
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(
        fontFamily: 'proxima',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black),
    bodyText1: TextStyle(
        fontFamily: 'proxima',
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: Colors.black),
    bodyText2: TextStyle(
        fontFamily: 'proxima',
        fontSize: 24,
        fontWeight: FontWeight.w300,
        color: Colors.black),
  ),
);
