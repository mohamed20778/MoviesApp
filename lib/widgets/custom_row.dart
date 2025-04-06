import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/theme/app_style.dart';

class CustomRowCard extends StatelessWidget {
  final String emoji;
  final String text;
  const CustomRowCard({super.key, required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: AppStyle.headlinestyle3()),
        SizedBox(width: 8.w),
        Text(text, style: AppStyle.headlinestyle3()),
      ],
    );
  }
}
