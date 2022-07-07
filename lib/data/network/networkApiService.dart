import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm_architecture/data/app_exceptions.dart';
import 'package:mvvm_architecture/data/network/baseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet Connection. Please check and try again!');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async{
    dynamic responseJson;
    try{
      Response response = await http.post(
          Uri.parse(url),
          body: data
      ).timeout(const Duration(seconds: 5));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchDataException('No Internet Connection. Please check and try again!');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 404:
        throw UnAuthorizedException(response.body.toString());

      default:
        throw FetchDataException("Error occured while communicating with server" + response.statusCode.toString());
    }
  }
}