import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/theme/app_style.dart';
import 'package:movies_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 24.w,
          top: 42.h,
          right: 24.w,
          bottom: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What do you want to watch?',
              style: AppStyle.headlinestyle1(),
            ),
            SizedBox(height: 40.h),
            Flexible(
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemBuilder: (context, index) => MovieCard(),

                    itemCount: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
