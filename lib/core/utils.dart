import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// General

double getScreenWidth(BuildContext context, {double? percentage}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return percentage != null ? percentage * screenWidth : screenWidth;
}

double getScreenHeight(BuildContext context, {double? percentage}) {
  double screenHeight = MediaQuery.of(context).size.height;
  return percentage != null ? percentage * screenHeight : screenHeight;
}

enum ColorPalette { green, lightGreen, dark, black, white }

const MyColors = [
  Color(0xFF43FFBB),
  Color(0xFFD8FFF0),
  Color(0xFF161825),
  Colors.black,
  Colors.white
];

Color getColor(ColorPalette color) {
  return MyColors[color.index];
}

const boxShadow = BoxShadow(
    spreadRadius: 0.0,
    blurRadius: 4.0,
    color: Color(0x44000000),
    offset: Offset(0, 4));

const boxShadows = [boxShadow];

final currencyFormat = NumberFormat.currency(
    locale: "de_DE",
    name: "EUR",
    symbol: "€",
    decimalDigits: 2,
    customPattern: "#,##0.00\u00A0€");

String getDatabaseDate(DateTime time) {
  String year = time.year.toString();
  String month = time.month.toString();
  String day = time.day.toString();
  return "$year-$month-$day";
}

String getPurchaseHistorieDate(DateTime time) {
  String year = time.year.toString();
  String month = time.month.toString();
  String day = time.day.toString();
  return "$day.$month.$year";
}

paddingHorizontal(double x) {
  return Padding(padding: EdgeInsets.only(top: 5.0 * x));
}

paddingVertical(double x) {
  return Padding(padding: EdgeInsets.only(left: 5.0 * x));
}

// Specific

class FadeCirclePainter extends CustomPainter {
  final myPaint;
  final Animation<double> radius;

  FadeCirclePainter(Animation<double> animation, double max, Color color)
      : radius = Tween<double>(begin: 0, end: max).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        myPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..isAntiAlias = true,
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(size.width / 2.0, size.height / 2.0), radius.value, myPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

int categorieToIndex(String categorie) {
  switch (categorie) {
    case "lunch":
      return 0;
    case "snack":
      return 1;
    case "credits":
      return 2;
    default:
      return -1;
  }
}
