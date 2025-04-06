import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/core/theme/app_fonts.dart';

class AppStyle {
  static TextStyle headlinestyle1() => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryColor,
    fontFamily: AppFonts.poppins,
  );
  static TextStyle headlinestyle2() => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.primaryColor,
    fontFamily: AppFonts.poppins,
  );
  static TextStyle headlinestyle3() => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.primaryColor,
    fontFamily: AppFonts.poppins,
  );
  static TextStyle smallTextStyle() => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.smallTextColor,
    fontFamily: AppFonts.poppins,
  );
}
