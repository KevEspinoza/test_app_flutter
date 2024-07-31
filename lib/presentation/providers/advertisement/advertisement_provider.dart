import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/infraestructure/repositories/advertisement_repository_impl.dart';

class AdvertisementProvider extends ChangeNotifier{
  bool _isLoading = false;
  final AdvertisementRepositoryImpl _repository = AdvertisementRepositoryImpl();
  List<AdvertisementsEntity> _advertisementData = [];

  bool get isLoading => _isLoading;
  List<AdvertisementsEntity> get advertisementData => _advertisementData;

  void setLoading( bool isLoading ){
    _isLoading = true;
    notifyListeners();
  }

  Future<void> getAdvertisement(int page) async{
    try{

      final response = await _repository.getAdvertisement(page);

      _advertisementData = response;
      notifyListeners();

    }on DioException{
      //TODO: MANDAR ERROR
      return;
    }
  }

}