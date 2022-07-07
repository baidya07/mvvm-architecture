

import 'package:mvvm_architecture/data/network/baseApiServices.dart';
import 'package:mvvm_architecture/data/network/networkApiService.dart';
import 'package:mvvm_architecture/resources/app_url.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiService();
  
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

    Future<dynamic> signupApi(dynamic data) async{
      try{
        dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerApiEndPoint , data);
        return response;
      }catch(e){
        throw e;
      }
  }
}