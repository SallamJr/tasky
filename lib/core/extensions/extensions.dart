import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SizedBoxXY on double {
  SizedBox get xSizedBox => SizedBox(width: this);
  SizedBox get ySizedBox => SizedBox(height: this);
}

extension Log on Object? {
  void debugLog() => dev.log(toString());
}

extension ScreenSize on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
}

extension CustomNavigator on BuildContext {
  void push({
    required String routeName,
    Object? arguments,
  }) =>
      Navigator.pushNamed(
        this,
        routeName,
        arguments: arguments,
      );

  void pushReplacement({
    required String routeName,
    Object? arguments,
  }) =>
      Navigator.pushReplacementNamed(
        this,
        routeName,
        arguments: arguments,
      );

  void pop() => Navigator.pop(
        this,
      );

  void popUntilFirst() => Navigator.popUntil(
        this,
        (route) => route.isFirst,
      );
}

extension DateTimeExtension on DateTime {
  // (22/5/1997)
  String dateMonthYear() {
    final DateFormat formattter = DateFormat('dd/MM/yyyy');
    return formattter.format(this);
  }

  // (May 22, 1997)
  String monthWardDateYear() {
    final DateFormat formattter = DateFormat('MMMM/d/yyyy');
    return formattter.format(this);
  }

  // (5:00 PM)
  String hourMinuteMeridiem() {
    final DateFormat formattter = DateFormat('h:mm a');
    return formattter.format(this);
  }

  // (22/5/1997 5:00 PM)
  String dateMonthYearHourMinuteMeridiem() {
    final DateFormat formattter = DateFormat('dd/MM/yyyy h:mm a');
    return formattter.format(this);
  }

  // (17:00)
  String hourMinute() {
    final DateFormat formattter = DateFormat('HH:mm');
    return formattter.format(this);
  }

  // (Thursday, May 22, 1997)
  String dayMonthDateYear() {
    final DateFormat formattter = DateFormat('EEEE, MMMM d, yyyy');
    return formattter.format(this);
  }
}
