import 'package:city_tales/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:city_tales/features/places/data/services/wiki_service.dart';
import 'package:city_tales/features/places/domain/entities/place_entity.dart';
import 'package:city_tales/features/places/presentation/widgets/start_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatefulWidget {
  final PlaceEntity place;

  const DetailsPage({super.key, required this.place});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final WikiService wikiService = WikiService();

  String description = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDescription();
  }

  Future<void> loadDescription() async {
    final result = await wikiService.getPlaceDescription(widget.place.name);
    setState(() {
      description = result;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavoriteCubit>();
    final isFav = favCubit.state.contains(widget.place.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place.name.split(',').first.trim(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 72, 163, 247),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.place.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A0050),
                      ),
                    ),
                    const SizedBox(height: 20),

                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Text(
                            description,
                            style: const TextStyle(fontSize: 18, height: 1.5),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    Size(double.infinity, 50.h),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 72, 163, 247),
                  ),
                ),
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  context.read<FavoriteCubit>().toggle(widget.place.id, isFav);
                },
                label: Text(
                  isFav ? 'Added to tour list' : 'Add to your tour list',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
              ),

              const SizedBox(height: 10),

              StartTourButton(
                color: Color(0xffDA6231),
                onPressed: () {
                  // open map or tour screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
