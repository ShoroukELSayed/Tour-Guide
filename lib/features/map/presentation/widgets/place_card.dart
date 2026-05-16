import 'package:city_tales/features/map/presentation/cubit/map_cubit.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:city_tales/features/places/presentation/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    super.key,
    required this.place,
    required this.selectedPlace,
  });
  final PlaceEntity place;
  final PlaceEntity? selectedPlace;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                place.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name.split(',').first.trim(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsPage(place: place),
                        ),
                      );
                    },
                    child: Text("Show Details"),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                context.read<MapCubit>().clearSelection();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
