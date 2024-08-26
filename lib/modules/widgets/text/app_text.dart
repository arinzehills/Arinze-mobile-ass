import 'package:flutter/material.dart';

class AppTextSize {
  static double xxbig = 32.0;
  static double xbig = 26.0;
  static double big = 20.0;
  static double medium = 18;
  static double normal = 16;
  static double small = 14;
  static double xsmall = 12;
}

class MyFontFamily {
  static String bungeeInline = 'BungeeInline';
  static String bestoom = 'Bestoom';
}

class AppTextss {}

class AppText extends StatelessWidget {
  const AppText(
    String this.text, {
    super.key,
    this.type,
    this.textSize = 16,
    this.italize = false,
    this.color,
    this.maxLines,
    this.align,
    this.withPadding = false,
    this.bold = false,
    this.fontFamily,
  });

  final String? text;
  final double? type;
  final double textSize;
  final bool italize;
  final Color? color;
  final int? maxLines;
  final TextAlign? align;
  final bool withPadding;
  final bool bold;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: withPadding ? 2.0 : 0),
        child: Text(
          text ?? 'text',
          maxLines: maxLines,
          textAlign: align,
          style: TextStyle(
              fontFamily: fontFamily,
              fontStyle: italize ? FontStyle.italic : null,
              overflow: TextOverflow.ellipsis,
              color: color ?? Colors.black,
              fontWeight: bold
                  ? FontWeight.bold
                  : type == AppTextSize.big || type == AppTextSize.medium
                      ? FontWeight.w600
                      : FontWeight.w400,
              fontSize: textSize),
        ),
      );
}
