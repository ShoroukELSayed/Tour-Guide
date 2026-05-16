import 'package:city_tales/core/location/location_service.dart';
import 'package:city_tales/core/location/location_tracker.dart';
import 'package:city_tales/core/network/network_info.dart';
import 'package:city_tales/core/services/notification_service.dart';
import 'package:city_tales/core/services/pexels_service.dart';
import 'package:city_tales/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:city_tales/features/category/presentation/cubit/category_cubit.dart';
import 'package:city_tales/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:city_tales/features/map/presentation/cubit/map_cubit.dart';
import 'package:city_tales/features/favorite/data/datasource/fav_local_ds.dart';
import 'package:city_tales/features/favorite/data/datasource/fav_remote_ds.dart';
import 'package:city_tales/features/places/data/datasource/hive_places_datasource.dart';
import 'package:city_tales/features/places/data/datasource/supabase_places_datasource.dart';
import 'package:city_tales/features/places/data/repositories/place_repository.dart';
import 'package:city_tales/features/places/data/services/places_api_service.dart';
import 'package:city_tales/features/places/presentation/cubit/places_cubit.dart';
import 'package:city_tales/features/splash/presentation/pages/splash_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await notificationService.initNotifications();

  await Supabase.initialize(
    url: 'https://qzkpinsrtqobrdlrupqh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6a3BpbnNydHFvYnJkbHJ1cHFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg3MTU4NzIsImV4cCI6MjA5NDI5MTg3Mn0.3r9pa7RuNcfgNNzo_OvxRpJ6F5M-Gz6d8D1jFUiRxdk',
  );
  await Hive.initFlutter();

  await Hive.openBox("placesBox");

  await Hive.box("placesBox").clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavoriteCubit(
            repo: PlaceRepository(
              pexels: PexelsService(Dio()),
              api: PlacesApiService(),
              supabase: SupabasePlacesDataSource(),
              hive: HivePlacesDataSource(),
              favRemote: FavRemoteDS(),
              favLocal: FavLocalDS(),
              network: NetworkInfo(),
            ),
          )..loadFavorites(),
        ),
        BlocProvider(
          create: (context) => PlacesCubit(
            favoriteCubit: context.read<FavoriteCubit>(),
            notificationService: NotificationService(),
            locationTracker: LocationTracker(),
            repo: PlaceRepository(
              pexels: PexelsService(Dio()),
              api: PlacesApiService(),
              supabase: SupabasePlacesDataSource(),
              hive: HivePlacesDataSource(),
              favRemote: FavRemoteDS(),
              favLocal: FavLocalDS(),
              network: NetworkInfo(),
            ),
            locationService: LocationService(),
          ),
        ),
        BlocProvider(create: (context) => MapCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => CategoryCubit(
            locationService: LocationService(),
            repo: PlaceRepository(
              pexels: PexelsService(Dio()),
              api: PlacesApiService(),
              supabase: SupabasePlacesDataSource(),
              hive: HivePlacesDataSource(),
              favRemote: FavRemoteDS(),
              favLocal: FavLocalDS(),
              network: NetworkInfo(),
            ),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'CityTales',
            debugShowCheckedModeBanner: false,
            home: child,
          );
        },
        child: const SplashPage(),
      ),
    );
  }
}
