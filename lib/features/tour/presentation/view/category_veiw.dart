import 'package:citytales/features/tour/presentation/manager/tour_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 1. الـ Model (للحفاظ على الـ Clean Code)
class PlaceModel {
  final String name;
  final String image;
  final String category;

  PlaceModel({required this.name, required this.image, required this.category});
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TourCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F2ED),
        appBar: _buildAppBar(context),
        body: BlocBuilder<TourCubit, TourState>(
          builder: (context, state) {
            // حل مشكلة الـ Error: بنتحقق إن الـ state هو TourInitial عشان نقرأ الداتا منه
            if (state is TourInitial) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    _buildTopActions(context),
                    SizedBox(height: 25.h),
                    // دلوقتي state.selectedCategory هتشتغل من غير Errors
                    _buildCategoriesTabs(context, state.selectedCategory),
                    SizedBox(height: 15.h),
                    Expanded(child: _buildPlacesGrid(state.selectedCategory)),
                  ],
                ),
              );
            }
            // حالة احتياطية بسيطة
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          },
        ),
      ),
    );
  }

  // --- الـ AppBar ---
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Category Search",
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  // --- أزرار Stops و Filters ---
  Widget _buildTopActions(BuildContext context) {
    return Row(
      children: [
        _buildActionButton(Icons.arrow_drop_up, "Stops", onTap: () {
          // لوجيك الـ Stops مستقبلاً
        }),
        SizedBox(width: 12.w),
        _buildActionButton(Icons.tune, "Filters", iconColor: Colors.orange,
            onTap: () {
          _showFilterBottomSheet(context);
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String text,
      {Color iconColor = Colors.black, VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 22.sp),
              SizedBox(width: 8.w),
              Text(text,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  // --- التابات العلوية ---
  Widget _buildCategoriesTabs(BuildContext context, String currentCategory) {
    final categories = ["Historical", "Museums", "Cafes", "Landmarks"];
    return SizedBox(
      height: 45.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == currentCategory;

          return GestureDetector(
            onTap: () => context.read<TourCubit>().changeCategory(category),
            child: Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey.shade600,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      height: 3.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2.r)),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- الجريد والفلترة ---
  Widget _buildPlacesGrid(String selectedCategory) {
    final List<PlaceModel> allPlaces = [
      PlaceModel(
          name: "Luxor Temple",
          image: "assets/images/luxor.jpg",
          category: "Historical"),
      PlaceModel(
          name: "Cairo Citadel",
          image: "assets/images/citadel.jpg",
          category: "Historical"),
      PlaceModel(
          name: "Alexandria Library",
          image: "assets/images/alexandria.jpg",
          category: "Museums"),
      PlaceModel(
          name: "Egyptian Museum",
          image: "assets/images/museum.jpg",
          category: "Museums"),
      PlaceModel(
          name: "Costa Cafe",
          image: "assets/images/cafe.jpg",
          category: "Cafes"),
      PlaceModel(
          name: "Pyramids",
          image: "assets/images/pyramids.jpg",
          category: "Landmarks"),
    ];

    final filtered =
        allPlaces.where((p) => p.category == selectedCategory).toList();

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.8,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) => _buildPlaceCard(filtered[index]),
    );
  }

  Widget _buildPlaceCard(PlaceModel place) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image:
            DecorationImage(image: AssetImage(place.image), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          ),
        ),
        child: Text(
          place.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp),
        ),
      ),
    );
  }

  // --- الفلتر Bottom Sheet ---
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r)))),
              SizedBox(height: 20.h),
              Text("Filter Options",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 25.h),
              Text("Rating",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              Row(
                  children: List.generate(
                      5,
                      (i) => Icon(Icons.star,
                          color: i < 4 ? Colors.orange : Colors.grey[300],
                          size: 26.sp))),
              SizedBox(height: 20.h),
              Text("Distance (km)",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
              Slider(
                  value: 40,
                  max: 100,
                  activeColor: Colors.orange,
                  onChanged: (v) {}),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r))),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Apply Filters",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
