import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/theme/app_style.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/cubits/get_details_cubit/get_details_cubit.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetDetailsCubit>(context).getDetails(widget.movieId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details', style: AppStyle.headlinestyle1()),
        centerTitle: true,
      ),
      body: BlocBuilder<GetDetailsCubit, GetDetailsState>(
        builder: (context, state) {
          if (state is GetDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetDetailsSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                      child: Image.network(
                        "${ApiConstants.baseImageUrl}${state.movieDetails!.posterPath}",
                        width: 375.w,
                        height: 210.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 150.h,
                      left: 29.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image.network(
                                  "${ApiConstants.baseImageUrl}${state.movieDetails!.backdropPath}",
                                  width: 95.w,
                                  height: 120.h,
                                  fit: BoxFit.fill,

                                  errorBuilder:
                                      (
                                        BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace,
                                      ) => Container(
                                        color: Colors.grey[800],
                                        width: 80,
                                        height: 120,
                                        child: const Icon(
                                          Icons.image,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 200.w),
                                child: Text(
                                  state.movieDetails!.title!,
                                  style: AppStyle.headlinestyle1(),

                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 84.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '🗓️ ${DateTime.parse(state.movieDetails!.releaseDate!).year}',
                      style: AppStyle.headlinestyle3(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('|'),
                    ),
                    Text(
                      '🕧 ${state.movieDetails!.runtime!}',
                      style: AppStyle.headlinestyle2(),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Text("About Movie", style: AppStyle.headlinestyle1()),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Text(
                    state.movieDetails!.overview!,
                    style: AppStyle.headlinestyle3(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          } else if (state is GetDetailsFailure) {
            return Center(child: Text(state.errmessage));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
