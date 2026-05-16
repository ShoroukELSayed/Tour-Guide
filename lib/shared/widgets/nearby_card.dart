import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/place_model.dart';

class NearbyCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;

  const NearbyCard({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              Image.network(
                place.imageUrl ?? 
                'https://via.placeholder.com/300x400?text=${Uri.encodeComponent(place.name)}',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: AppColors.cardBackground,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.cardBackground,
                    child: Icon(
                      Icons.image_not_supported,
                      color: AppColors.textSecondary,
                      size: responsive.wp(10),
                    ),
                  );
                },
              ),
              
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              
              // Content
              Padding(
                padding: EdgeInsets.all(responsive.wp(3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.wp(3.8),
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: responsive.hp(0.5)),
                    if (place.distance != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.secondary,
                            size: 14,
                          ),
                          SizedBox(width: responsive.wp(1)),
                          Text(
                            '${(place.distance! / 1000).toStringAsFixed(1)} km',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: responsive.wp(3),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              
              // Category Badge
              Positioned(
                top: responsive.wp(2),
                right: responsive.wp(2),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(2),
                    vertical: responsive.hp(0.3),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    place.categories.isNotEmpty 
                        ? place.categories.first.split('.').last.toUpperCase()
                        : 'HERITAGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.wp(2.2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}