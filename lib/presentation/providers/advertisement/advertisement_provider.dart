import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_app/domain/entities/advertisements_entity.dart';
import 'package:test_app/infraestructure/mappers/advertisement_mapper.dart';
import 'package:test_app/infraestructure/repositories/advertisement_repository_impl.dart';

typedef ErrorCallback = void Function(String errorMessage);

class AdvertisementProvider extends ChangeNotifier{
  ErrorCallback? onErrorCallback;
  bool _isLoading = false;
  bool _isLoadingPage = false;
  int _currentPage = 0;
  AdvertisementType? _typeSelected;
  final scrollController = ScrollController();
  final AdvertisementRepositoryImpl _repository = AdvertisementRepositoryImpl();
  List<AdvertisementsEntity> _advertisementData = [];

  bool get isLoading => _isLoading;
  bool get isLoadingPage => _isLoadingPage;
  AdvertisementType? get typeSelected => _typeSelected;
  List<AdvertisementsEntity> get advertisementData{
    if(_typeSelected == null) return _advertisementData;

    return _advertisementData.where((e)=> e.type == _typeSelected).toList();
  }

  AdvertisementsEntity getAdvertisementById(String id){
    return _advertisementData.where((e)=> e.id == id).first;
  }

  void setLoading( bool loading ){
    _isLoading = loading;
    notifyListeners();
  }

  void setTypeSelected( AdvertisementType type){
    if(type == _typeSelected){
      _typeSelected = null;
      notifyListeners();
      return;
    } 

    _typeSelected = type;
    notifyListeners();
  }

  void setLoadingPage( bool loading ){
    _isLoadingPage = loading;
    notifyListeners();
  }

  void initScrollController(){
    scrollController.addListener((){
      if((scrollController.position.pixels) >= scrollController.position.maxScrollExtent){
        getAdvertisement();
      }
    });
  }
  

  Future<void> getAdvertisement() async{
    try{

      if(_currentPage != 0) {
        setLoadingPage(true);
      } else {
        setLoading(true);
      }

      int start = _currentPage * 5;

      int end = start + 5;

      final response = await _repository.getAdvertisement(_currentPage);

      if(response.length >= end){
        _advertisementData = [..._advertisementData, ...response.sublist(start, end)];
      }
      
      notifyListeners();

      if(_currentPage != 0) {
        setLoadingPage(false);
      } else {
        setLoading(false);
      }
      
      _currentPage +=1;

    }on DioException{
      onErrorCallback?.call('Ocurrio un error inesperado, intenta nuevamente.');
      
      if(_currentPage != 0) {
        setLoadingPage(false);
      } else {
        setLoading(false);
      }
    }
  }

}