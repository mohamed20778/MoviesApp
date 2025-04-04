import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/services/movDetails_service.dart';
import 'package:movies_app/core/services/movie_service.dart';
import 'package:movies_app/core/theme/app_color.dart';
import 'package:movies_app/core/theme/app_style.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/cubits/get_details_cubit/get_details_cubit.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/routing/app_routes.dart';
import 'package:movies_app/view/movie_details.dart';
import 'package:movies_app/widgets/customRow_card.dart';

class MovieCard extends StatefulWidget {
  MovieModel movieItem;
  MovieCard({super.key, required this.movieItem});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  MovieModel? movieItem;
  MovdetailsService? service;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) =>
                          GetDetailsCubit(detailsService: MovdetailsService()),
                  child: MovieDetailsPage(movieId: widget.movieItem.id!),
                ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
              child: Image.network(
                "${ApiConstants.baseImageUrl}${widget.movieItem.posterPath}",
                width: 95.w,
                height: 120.h,
                fit: BoxFit.cover,

                errorBuilder:
                    (
                      BuildContext context,
                      Object exception,
                      StackTrace? stackTrace,
                    ) => Container(
                      color: Colors.grey[800],
                      width: 80,
                      height: 120,
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(9.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Rating
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.movieItem.title!,
                            style: AppStyle.headlinestyle2(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColor.iconColor,
                              size: 16,
                            ),
                            Text(
                              widget.movieItem.voteAverage.toString(),
                              style: AppStyle.headlinestyle3(),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRowCard(
                          emoji: '📖',
                          text: widget.movieItem.originalLanguage!,
                        ),
                        SizedBox(height: 4.h),
                        CustomRowCard(
                          emoji: '🕧',
                          text:
                              "${DateTime.parse(widget.movieItem.releaseDate!).year}",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Helper Widget
    );
  }
}
