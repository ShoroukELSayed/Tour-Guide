class PlaceEntity {
  final String id;
  final String name;
  final String category;
  final double lat;
  final double lng;
  final String image;
  final bool isFavorite;

  PlaceEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.lat,
    required this.lng,
    required this.image,
    this.isFavorite = false,
  });
  PlaceEntity copyWith({
    String? id,
    String? name,
    String? category,
    double? lat,
    double? lng,
    String? image,
    bool? isFavorite,
  }) {
    return PlaceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
