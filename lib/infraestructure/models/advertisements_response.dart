import 'dart:convert';

List<AdvertisementsResponse> advertisementsResponseFromJson(String str) => List<AdvertisementsResponse>.from(json.decode(str).map((x) => AdvertisementsResponse.fromJson(x)));

String advertisementsResponseToJson(List<AdvertisementsResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdvertisementsResponse {
    final String? createdAt;
    final String? title;
    final String? description;
    final int? price;
    final int? category;
    final int? totalReviews;
    final String? imageUrl;
    final double? latitude;
    final double? longitude;
    final String? id;

    AdvertisementsResponse({
        this.createdAt,
        this.title,
        this.description,
        this.price,
        this.category,
        this.totalReviews,
        this.imageUrl,
        this.latitude,
        this.longitude,
        this.id,
    });

    factory AdvertisementsResponse.fromJson(Map<String, dynamic> json) => AdvertisementsResponse(
        createdAt: json["createdAt"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        totalReviews: json["total_reviews"],
        imageUrl: json["image_url"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "title": title,
        "description": description,
        "price": price,
        "category": category,
        "total_reviews": totalReviews,
        "image_url": imageUrl,
        "latitude": latitude,
        "longitude": longitude,
        "id": id,
    };
}
