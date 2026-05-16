import 'package:citytales/features/tour_list/viewmodels/tour_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';

class MyTourListScreen extends StatelessWidget {
  const MyTourListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TourViewModel(context.read())..loadTourList(),
      child: const _MyTourListContent(),
    );
  }
}

class _MyTourListContent extends StatelessWidget {
  const _MyTourListContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TourViewModel>();
    final responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tour List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: viewModel.tourList.isNotEmpty ? viewModel.startTour : null,
          ),
        ],
      ),
      body: viewModel.tourList.isEmpty
          ? _buildEmptyState(context)
          : ReorderableListView.builder(
              padding: EdgeInsets.all(responsive.wp(4)),
              itemCount: viewModel.tourList.length,
              onReorder: viewModel.reorderItems,
              itemBuilder: (context, index) {
                final place = viewModel.tourList[index];
                return Card(
                  key: Key(place.id),
                  margin: EdgeInsets.only(bottom: responsive.hp(1.5)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        place.imageUrl ?? 
                        'https://via.placeholder.com/60?text=${Uri.encodeComponent(place.name[0])}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      place.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      place.address ?? 'No address',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => viewModel.removeFromTour(place.id),
                        ),
                        const Icon(Icons.drag_handle, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      floatingActionButton: viewModel.tourList.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: viewModel.startTour,
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.navigation),
              label: Text(
                'Start Tour (${viewModel.tourList.length} stops)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final responsive = Responsive(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.map_outlined,
            size: responsive.wp(20),
            color: AppColors.textSecondary.withOpacity(0.5),
          ),
          SizedBox(height: responsive.hp(2)),
          Text(
            'No places added yet',
            style: TextStyle(
              fontSize: responsive.wp(5),
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: responsive.hp(1)),
          Text(
            'Explore the map and add places to your tour',
            style: TextStyle(
              fontSize: responsive.wp(3.5),
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: responsive.hp(3)),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to map
            },
            icon: const Icon(Icons.explore),
            label: const Text('Explore Map'),
          ),
        ],
      ),
    );
  }
}