import 'package:flutter/material.dart';

typedef ErrorCallback = void Function(String errorMessage);
typedef IsValidCallback = void Function();

class SellerProvider extends ChangeNotifier{
  ErrorCallback? onErrorCallback;
  IsValidCallback? isValidCallback;
  String _email = '';
  String _name = '';
  String _data = '';
  final _regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String get email => _email;
  String get name => _name;
  String get data => _data;

  void checkFormsValid(){
    if(_email.isEmpty || _name.isEmpty || _data.isEmpty){
      onErrorCallback?.call('Favor de llenar todos los campos.');
      return;
    }

    if(!_regex.hasMatch(_email)){
      onErrorCallback?.call('Formato de correo invalido.');
      return;
    }

    isValidCallback?.call();
  }

  void clear(){
    _email = '';
    _name = '';
    _data = '';
    notifyListeners();
  }

  void onEmailChange(String value){
    _email = value;
    notifyListeners();
  }

  void onNameChange(String value){
    _name = value;
    notifyListeners();
  }

  void onDataChange(String value){
    _data = value;
    notifyListeners();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}