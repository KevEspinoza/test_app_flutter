import 'package:test_app/config/constants/utils.dart';
import 'package:test_app/domain/datasource/advertisement_datasource.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/infraestructure/mappers/advertisement_mapper.dart';
import 'package:test_app/infraestructure/models/advertisements_response.dart';

class AdvertisementDataSourceImpl extends AdvertisementDataSource{
  
  @override
  Future<List<AdvertisementsEntity>> getAdvertisement(int page) async{
    final response = await Utils.getDio().get('advertisement');

    final advertisementResponse = advertisementsResponseFromJson(response.data.toString());

    return advertisementResponse.map((e)=> AdvertisementMapper.advertisementResponseToEntity(e)).toList();
  }

}