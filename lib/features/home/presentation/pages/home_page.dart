import 'package:city_tales/core/constants/app_images.dart';
import 'package:city_tales/core/errors/failures.dart';
import 'package:city_tales/core/utils/snackbar_helper.dart';
import 'package:city_tales/core/widgets/location_dialog.dart';
import 'package:city_tales/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:city_tales/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:city_tales/features/home/presentation/widgets/home_app_bar.dart';
import 'package:city_tales/features/home/presentation/widgets/nearby_list_view.dart';
import 'package:city_tales/features/home/presentation/widgets/taps_list_view.dart';
import 'package:city_tales/features/places/presentation/cubit/places_cubit.dart';
import 'package:city_tales/features/places/presentation/cubit/places_state.dart';
import 'package:city_tales/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  Future<void> _initData() async {
    if (!mounted) return;

    final favCubit = context.read<FavoriteCubit>();
    final placesCubit = context.read<PlacesCubit>();

    await favCubit.loadFavorites();

    if (!mounted) return;

    await placesCubit.fetchNearbyPlaces();

    if (!mounted) return;

    placesCubit.startLiveNearbyUpdates();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlacesCubit, PlacesState>(
      listener: (context, state) {
        if (state is PlacesError) {
          final failure = state.failure;

          if (failure is LocationPermissionFailure) {
            LocationDialog.showPermissionDenied(
              context,
              permanentlyDenied: failure.permanentlyDenied,
            );
            return;
          }

          if (failure is LocationServiceFailure) {
            LocationDialog.showLocationDisabled(context);
            return;
          }

          SnackBarHelper.show(context, failure);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.iconsBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                ListView(
                  children: [
                    HomeAppBar(),
                    Gap(0.07.sh),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            'Nearby Places.',
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(child: Divider(thickness: 2)),
                        ],
                      ),
                    ),
                    Gap(0.02.sh),
                    NearbyListView(),
                  ],
                ),
                Positioned(
                  top: 0.05.sh,
                  right: 0.05.sw,
                  child: InkWell(
                    onTap: () async {
                      final userName = await context.read<AuthCubit>()
                          .getUserName();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(userName: userName),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.r,
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.365.sh,
                  left: 0.024.sw,
                  right: 0.024.sw,
                  child: TapsListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
