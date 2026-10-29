import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherIcon extends StatelessWidget {
  final int code;
  final bool isDay;
  final double size;

  const WeatherIcon({
    super.key,
    required this.code,
    this.isDay = true,
    this.size = 56,
  });

  String iconPath() {
    if (code == 1000) {
      return isDay ? 'Main/Sunny.svg' : 'Main/Moon.svg';
    }
    if (code == 1003) {
      return isDay
          ? 'Cloudy_Sunny/Cloudy_Sunny.svg'
          : 'Cloudy_Moon/Cloudy_Moon.svg';
    }
    if ([1087, 1273, 1276, 1279, 1282].contains(code)) {
      return 'Main/Storm_Lightning.svg';
    }
    if ([
      1066,
      1114,
      1117,
      1210,
      1213,
      1216,
      1219,
      1222,
      1225,
      1255,
      1258,
    ].contains(code)) {
      return 'Cloudy/Snow.svg';
    }
    if ([
      1069,
      1072,
      1168,
      1171,
      1198,
      1201,
      1204,
      1207,
      1237,
      1249,
      1252,
      1261,
      1264,
    ].contains(code)) {
      return 'Main/Hail.svg';
    }
    if ([
      1063,
      1150,
      1153,
      1180,
      1183,
      1186,
      1189,
      1192,
      1195,
      1240,
      1243,
      1246,
    ].contains(code)) {
      return 'Cloudy/Rain.svg';
    }
    if ((code >= 1012 && code <= 1048) || code == 1135 || code == 1147) {
      return 'Foggy/Foggy.svg';
    }
    return 'Cloudy/Cloudy.svg';
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'lib/icons/${iconPath()}',
      width: size,
      height: size,
    );
  }
}
