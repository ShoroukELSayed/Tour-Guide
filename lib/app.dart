import 'package:citytales/core/theme/app_theme.dart';
import 'package:citytales/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/services/geoapify_service.dart';
import 'core/services/location_service.dart';
import 'data/repositories/place_repository.dart';

class CityTalesApp extends StatelessWidget {
  const CityTalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initRepository(context),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final repository = snapshot.data as PlaceRepository;

        return MultiProvider(
          providers: [
            Provider.value(value: repository),
          ],
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'CityTales',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.light,
                home: const SplashView(),
              );
            },
          ),
        );
      },
    );
  }

  Future<PlaceRepository> _initRepository(BuildContext context) async {
    final geoapifyService = GeoapifyService();
    final locationService = LocationService();

    final repository = PlaceRepository(
      geoapifyService,
      locationService,
    );

    // 🔥 مهم جدًا
    await repository.init();

    return repository;
  }
}