import 'package:test_app/domain/datasource/advertisement_datasource.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/domain/repositories/advertisement_repository.dart';
import 'package:test_app/infraestructure/datasource/advertisement_datasource_impl.dart';

class AdvertisementRepositoryImpl extends AdvertisementRepository{

  final AdvertisementDataSource dataSource;

  AdvertisementRepositoryImpl({
    AdvertisementDataSource? dataSource
  }): dataSource = dataSource ?? AdvertisementDataSourceImpl();

  @override
  Future<List<AdvertisementsEntity>> getAdvertisement(int page) {
    return dataSource.getAdvertisement(page);
  }

}