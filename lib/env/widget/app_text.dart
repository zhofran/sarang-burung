import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.textColor = const Color(0xff000000),
    this.size = 14,
    this.maxLines,
    this.weight = FontWeight.w500,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis,
    this.style = FontStyle.normal,
  });

  final String text;
  final Color textColor;
  final double size;
  final int? maxLines;
  final FontWeight weight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final FontStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 99,
      overflow: overflow,
      style: GoogleFonts.outfit(
        color: textColor,
        fontWeight: weight,
        fontSize: size,
        fontStyle: style,
      ),
      textAlign: textAlign,
    );
  }
}
