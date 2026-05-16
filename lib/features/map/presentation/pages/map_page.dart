
import 'package:city_tales/features/map/presentation/cubit/map_cubit.dart';
import 'package:city_tales/features/map/presentation/widgets/place_card.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final List<PlaceEntity> places;
  final LatLng userLocation;

  const MapPage({
    super.key,
    required this.places,
    required this.userLocation,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _controller;

  void _moveTo(LatLng location) {
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 16,
        ),
      ),
    );
  }

  Set<Marker> _buildMarkers(BuildContext context) {
    final selectedPlace = context.watch<MapCubit>().state;

    return {
      // User Marker
      Marker(
        markerId: const MarkerId("user_location"),
        position: widget.userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        ),
      ),

      // Places Markers
      ...widget.places.map((place) {
        final isSelected = selectedPlace?.id == place.id;

        return Marker(
          markerId: MarkerId(place.id.toString()),
          position: LatLng(place.lat, place.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            isSelected
                ? BitmapDescriptor.hueAzure
                : BitmapDescriptor.hueRed,
          ),
          onTap: () {
            context.read<MapCubit>().selectPlace(place);

            _moveTo(
              LatLng(place.lat, place.lng),
            );
          },
        );
      }),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
      ),

      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.userLocation,
              zoom: 16,
            ),

            onMapCreated: (controller) {
              _controller = controller;
            },

            myLocationEnabled: true,
            myLocationButtonEnabled: true,

            markers: _buildMarkers(context),
          ),

          BlocBuilder<MapCubit, PlaceEntity?>(
            builder: (context, selectedPlace) {
              if (selectedPlace == null) {
                return const SizedBox();
              }

              return Positioned(
                bottom: 100,
                left: 20,
                right: 20,
                child: PlaceCard(
                  place: selectedPlace,
                  selectedPlace: selectedPlace,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}