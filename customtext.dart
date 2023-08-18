import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String sTextToDisplay;
  final double dTextSize;
  final bool bMakeBold;
  final Color colorOfText;
  final int maxLines;
  final TextAlign textAlign;

  const CustomText({
    Key? key,
    required this.sTextToDisplay,
    required this.dTextSize,
    required this.bMakeBold,
    required this.colorOfText,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleNormal = GoogleFonts.lato(
      textStyle: TextStyle(color: colorOfText,),
      fontSize: dTextSize,
    );

    TextStyle textStyleBold = GoogleFonts.lato(
      textStyle: TextStyle(color: colorOfText,),
      fontWeight: FontWeight.bold,
      fontSize: dTextSize,
    );

    return Text(
      sTextToDisplay,
      style: bMakeBold ? textStyleBold : textStyleNormal,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
