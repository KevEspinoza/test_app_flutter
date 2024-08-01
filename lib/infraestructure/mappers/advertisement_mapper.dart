import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/infraestructure/models/advertisements_response.dart';

class AdvertisementMapper{

  static AdvertisementsEntity advertisementResponseToEntity (AdvertisementsResponse response ) => AdvertisementsEntity(
    id: response.id ?? '',
    title: response.title ?? '', 
    description: response.description ?? '', 
    price: response.price ?? 0, 
    totalReviews: response.totalReviews ?? 0, 
    imageUrl: response.imageUrl == null ? '' : 'assets/images/${response.imageUrl}', 
    lat: response.latitude ?? 0, 
    lng: response.longitude ?? 0,
    type: categoryToAdvertisementType(response.category),
  );

  static AdvertisementType categoryToAdvertisementType ( int? category ){

    switch(category){
      case 1: return AdvertisementType.phones;
      case 2: return AdvertisementType.laptops;
      case 3: return AdvertisementType.smartWatchs;
      default: return AdvertisementType.laptops;
    }

  }

}

enum AdvertisementType{
  phones,
  laptops,
  smartWatchs,
}