class AdvertisementsEntity{
  final String title;
  final String description;
  final int price;
  final int totalReviews;
  final String imageUrl;
  final double lat;
  final double lng;

  AdvertisementsEntity({
    required this.title,
    required this.description,
    required this.price,
    required this.totalReviews,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });
}