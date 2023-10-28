import 'package:delivery_screens/shared/score_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'color_theme.dart';

double wXD(double size, BuildContext context) {
  return MediaQuery.of(context).size.width / 375 * size;
}

double hXD(double size, BuildContext context) {
  return MediaQuery.of(context).size.height / 667 * size;
}

double maxHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double maxWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

TextStyle textFamily({
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  Color? color,
}) {
  // print('fontSize nul?? ${fontSize == null}');
  // print('fontWeight nul?? ${fontWeight == null}');
  // print('height nul?? ${height == null}');
  // FontWeight _fontWeight = fontWeight == null ? FontWeight.w600 : fontWeight;
  return GoogleFonts.montserrat(
    fontSize: fontSize ?? 13,
    color: color ?? ColorTheme.textDarkBlue,
    fontWeight: fontWeight ?? FontWeight.w500,
    height: height ?? null,
  );
  // return TextStyle(
  //   fontFamily: 'Montserrat',
  //   fontSize: fontSize ?? 13,
  //   color: color ?? ColorTheme.textDarkBlue,
  //   fontWeight: fontWeight ?? FontWeight.w600,
  //   height: height ?? null,
  // );
}

String formatedCurrency(var value) {
  var newValue = new NumberFormat("#,##0.00", "pt_BR");
  return newValue.format(value);
}

void pickDate(context, {required void Function(DateTime?) onConfirm}) async {
  late OverlayEntry dateOverlay;
  dateOverlay = OverlayEntry(
    builder: (context) => ScoreDatePicker(
      onConfirm: (date) {
        onConfirm(date);
        dateOverlay.remove();
      },
      onCancel: () {
        dateOverlay.remove();
      },
    ),
  );
  Overlay.of(context)!.insert(dateOverlay);
}

showToast(String msg) => Fluttertoast.showToast(msg: msg);
