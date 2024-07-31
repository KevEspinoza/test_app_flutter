import 'package:test_app/domain/entities/advertisements_entity.dart';

abstract class AdvertisementRepository{
  Future<List<AdvertisementsEntity>> getAdvertisement(int page);
}