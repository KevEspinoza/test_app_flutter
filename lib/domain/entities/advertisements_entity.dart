import 'package:test_app/infraestructure/mappers/advertisement_mapper.dart';

class AdvertisementsEntity{
  final String id;
  final String title;
  final String description;
  final int price;
  final int totalReviews;
  final String imageUrl;
  final double lat;
  final double lng;
  final AdvertisementType type;

  AdvertisementsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.totalReviews,
    required this.imageUrl,
    required this.lat,
    required this.lng,
    required this.type,
  });
}