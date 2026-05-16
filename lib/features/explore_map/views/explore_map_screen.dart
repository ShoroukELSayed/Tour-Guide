import 'package:citytales/data/repositories/place_repository.dart';
import 'package:citytales/features/explore_map/widgets/details_card.dart';
import 'package:citytales/features/explore_map/widgets/map_widget.dart';
import 'package:citytales/features/explore_map/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/responsive.dart';
import '../viewmodels/map_viewmodel.dart';

class ExploreMapScreen extends StatefulWidget {
  const ExploreMapScreen({super.key});

  @override
  State<ExploreMapScreen> createState() => _ExploreMapScreenState();
}

class _ExploreMapScreenState extends State<ExploreMapScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapViewModel(
        context.read<PlaceRepository>(),
      )..initialize(),
      child: _ExploreMapContent(
        mapController: _mapController,
      ),
    );
  }
}

class _ExploreMapContent extends StatelessWidget {
  final MapController mapController;

  const _ExploreMapContent({
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapViewModel>();
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Map',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ExploreMapWidget(
            mapController: mapController,
          ),
          SearchBarWidget(),

          /// DETAILS CARD
          if (vm.selectedPlace != null)
            DetailsCard(responsive: responsive, vm: vm),

          /// BUTTONS
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton.small(
              heroTag: 'locate',
              onPressed: () {
                if (vm.userPosition != null) {
                  mapController.move(
                    LatLng(
                      vm.userPosition!
                          .latitude,
                      vm.userPosition!
                          .longitude,
                    ),
                    16,
                  );
                }
              },
              child: const Icon(
                Icons.my_location,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
