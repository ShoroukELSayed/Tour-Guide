import '../../domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  PlaceModel({
    required super.id,
    required super.name,
    required super.category,
    required super.lat,
    required super.lng,
    required super.image,
    super.isFavorite = false,
  });

  factory PlaceModel.fromApi(Map<String, dynamic> json) {
    final props = json['properties'] ?? {};

    return PlaceModel(
      id: props['place_id'] ?? '',
      name: props['name_en'] ?? props['formatted'] ?? props['name'] ?? "",
      category:
          (props['categories'] as List?)?.map((e) => e.toString()).join(", ") ??
          'unknown',
      lat: (props['lat'] ?? 0).toDouble(),
      lng: (props['lon'] ?? 0).toDouble(),
      image: '',
      isFavorite: false,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      lat: (json['lat']).toDouble(),
      lng: (json['lng']).toDouble(),
      image: json['image'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "lat": lat,
      "lng": lng,
      "image": image,
      "is_favorite": isFavorite,
    };
  }

  factory PlaceModel.fromEntity(PlaceEntity entity) {
    return PlaceModel(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      lat: entity.lat,
      lng: entity.lng,
      image: entity.image,
      isFavorite: entity.isFavorite,
    );
  }
  @override
  PlaceModel copyWith({
    String? id,
    String? name,
    double? lat,
    double? lng,
    String? image,
    bool? isFavorite,
    String? category,
  }) {
    return PlaceModel(
      category: category ?? this.category,
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

extension PlaceModelMapper on PlaceModel {
  PlaceEntity toEntity() {
    return PlaceEntity(
      id: id,
      name: name,
      lat: lat,
      lng: lng,
      category: category,
      image: image,
      isFavorite: false, 
    );
  }
}
