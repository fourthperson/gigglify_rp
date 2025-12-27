import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textRegular = GoogleFonts.lexendDeca().copyWith(
  color: Colors.black,
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

TextStyle textMedium = textRegular.copyWith(fontWeight: FontWeight.w500);
TextStyle textBold = textRegular.copyWith(fontWeight: FontWeight.w700);
TextStyle textLight = textRegular.copyWith(fontWeight: FontWeight.w100);
