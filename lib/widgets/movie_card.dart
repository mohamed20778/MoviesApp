import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/routing/app_routes.dart';
import 'package:movies_app/widgets/customRow_card.dart';

class MovieCard extends StatefulWidget {
  MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isfavourite = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(AppRoutes.movieDetails);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        height: 120, // Fixed height for the card
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.network(
                'https://lumiere-a.akamaihd.net/v1/images/p_encanto_homeent_22359_4892ae1c.jpeg',
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
                            'Spiderman',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text(
                              '9.5',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRowCard(emoji: '📖', text: 'Action'),
                        const SizedBox(height: 4),
                        CustomRowCard(emoji: '🐀', text: '2019'),
                        const SizedBox(height: 4),
                        CustomRowCard(emoji: '💡', text: '139 minutes'),
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
