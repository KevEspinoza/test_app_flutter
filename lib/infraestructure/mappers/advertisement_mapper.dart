import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/infraestructure/models/advertisements_response.dart';

class AdvertisementMapper{

  static AdvertisementsEntity advertisementResponseToEntity (AdvertisementsResponse response ) => AdvertisementsEntity(
    title: response.title ?? '', 
    description: response.description ?? '', 
    price: response.price ?? 0, 
    totalReviews: response.totalReviews ?? 0, 
    imageUrl: response.imageUrl == null ? '' : 'assets/images/${response.imageUrl}', 
    lat: response.latitude ?? 0, 
    lng: response.longitude ?? 0
  );

}