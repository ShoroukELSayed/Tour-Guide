import 'package:city_tales/features/category/presentation/cubit/category_cubit.dart';
import 'package:city_tales/features/category/presentation/cubit/Category_state.dart';
import 'package:city_tales/features/category/presentation/widgets/place_card_category.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:city_tales/features/places/presentation/cubit/places_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String currentCategoryTag = "entertainment.museum,tourism.sights";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() {
    context.read<CategoryCubit>().fetchPlaces(currentCategoryTag);
  }

  String _getCategoryStaticImage(String tag) {
    if (tag == "tourism.museum") {
      return "https://images.unsplash.com/photo-1572252009286-268acec5ca0a?q=80&w=500";
    } else if (tag == "accommodation.hotel") {
      return "https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=500";
    } else if (tag == "catering.restaurant") {
      return "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=500";
    } else if (tag == "catering.cafe") {
      return "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=500";
    }
    return "https://images.unsplash.com/photo-1539650116574-8efeb43e2750?q=80&w=500";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 25.h),
            _buildCategoriesTabs(),
            SizedBox(height: 15.h),
            Expanded(
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF002C54),
                      ),
                    );
                  } else if (state is CategoryLoaded) {
                    return _buildPlacesGrid(state.places);
                  } else if (state is PlacesError) {
                    return Center(
                      child: Text(
                        "Failed to load locations",
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    );
                  }
                  return const Center(child: Text("Select a category"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlacesGrid(List<PlaceEntity> places) {
    if (places.isEmpty) {
      return const Center(child: Text("No places found"));
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.76,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        final imgUrl = place.image.isNotEmpty
            ? place.image
            : _getCategoryStaticImage(currentCategoryTag);

        return PlaceCardCategory(place: place, imgUrl: imgUrl);
      },
    );
  }

  Widget _buildCategoriesTabs() {
    final Map<String, String> categories = {
      "Museums": "entertainment.museum,tourism.sights",
      "Hotels": "accommodation.hotel",
      "Restaurants": "catering.restaurant",
      "Cafes": "catering.cafe",
    };
    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.entries.map((entry) {
          final isSelected = currentCategoryTag == entry.value;

          return GestureDetector(
            onTap: () {
              setState(() {
                currentCategoryTag = entry.value;
              });
              _fetchData();
            },
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF002C54) : Colors.white,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Center(
                child: Text(
                  entry.key,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF002C54),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Explore Categories",
        style: TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
