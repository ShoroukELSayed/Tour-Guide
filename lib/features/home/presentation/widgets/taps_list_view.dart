import 'package:city_tales/features/category/presentation/cubit/category_cubit.dart';
import 'package:city_tales/features/home/presentation/widgets/category_tap.dart';
import 'package:city_tales/features/map/presentation/pages/map_page.dart';
import 'package:city_tales/features/places/presentation/cubit/places_cubit.dart';
import 'package:city_tales/features/places/presentation/cubit/places_state.dart';
import 'package:city_tales/features/category/presentation/pages/categories_page.dart';
import 'package:city_tales/features/tour_list/presentation/view/tour_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;

class TapsListView extends StatelessWidget {
  const TapsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 0.02.sw,
      children: [
        Expanded(
          child: CategoryTap(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => const MapPage()),
            //   );
            // },
            onTap: () {
              final state = context.read<PlacesCubit>().state;

              if (state is PlacesLoaded) {
                final userLocation = gmaps.LatLng(state.lat, state.lng);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapPage(
                      places: state.places,
                      userLocation: userLocation,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Wait, loading places...")),
                );
              }
            },
            icon: Icons.map,
            title: 'Explore Map',
            color: const Color.fromARGB(255, 100, 148, 155),
          ),
        ),
        Expanded(
          child: CategoryTap(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<CategoryCubit>(),
                    child: const CategoryPage(),
                  ),
                ),
              );
            },
            icon: Icons.category_outlined,
            title: 'Categories',
            color: const Color(0xffBF5317),
          ),
        ),
        Expanded(
          child: CategoryTap(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TourListView()),
              );
            },
            icon: Icons.list_alt_outlined,
            title: 'My Tour List',
            color: const Color(0xffE2911F),
          ),
        ),
      ],
    );
  }
}
