import 'package:flutter/material.dart';

const Color blueBold = Color(0xff2979ff);
const Color blue = Color(0xff172CA1);
const Color blue100 = Color(0xffbbdefb);
const Color purle800 = Color(0xFF6A1B9A);
const Color purple300 = Color(0xFFBA68C8);
const Color purple = Color(0xFF9C27B0);

const Color thirdBackgroundColor = Color(0xff556AEF);
const Color dividerColor = Color(0xff485CDF);
const Color black = Color(0xff000000);
const Color white = Color(0xffffffff);
const Color mainFontColor = Color(0xff4E62E6);
const Color yellow = Color(0xffFDEA03);

const BoxDecoration gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment(-1, -1),
    end: Alignment(1, 1),
    colors: [blueBold, blue, thirdBackgroundColor],
  ),
);
