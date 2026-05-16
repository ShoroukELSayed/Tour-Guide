import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:city_tales/features/places/presentation/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.place});

  final PlaceEntity place;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailsPage(place: place)),
        );
      },
      child: Container(
        width: 0.40.sw,
        height: 0.25.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(place.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 0.40.sw,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: Colors.black.withAlpha(190),
            ),
            child: Text(
              place.name.split(',').first.trim(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
