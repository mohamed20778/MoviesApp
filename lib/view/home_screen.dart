import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/core/theme/app_style.dart';
import 'package:movies_app/cubits/get_movie_cubit/get_movie_cubit.dart';
import 'package:movies_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetMovieCubit>(context).getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetMovieCubit, GetMovieState>(
        builder: (context, state) {
          if (state is GetMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.iconColor),
            );
          } else if (state is GetMovieSuccess) {
            return Padding(
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
                          itemBuilder:
                              (context, index) => MovieCard(
                                movieItem: state.movieListState![index],
                              ),

                          itemCount: state.movieListState!.length,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetMovieFailure) {
            return const Center(child: Text('Something went wrong'));
          }
          return Center(
            child: Column(
              children: [
                SizedBox(height: 100.h),
                MaterialButton(onPressed: () async {}),
                Text('Something went wrong in cubit'),
              ],
            ),
          );
        },
      ),
    );
  }
}
