

import 'dart:io';

import 'package:citizen_app/constants/api.dart';
import 'package:dio/dio.dart';

class HttpService {
  String? host;
  BaseOptions? baseOptions;
  Dio? dio;
  int connectTimeout = 60000;
  int receiveTimeout = 60000;


  HttpService() {
    initHttpService();
  }

  //get the remote config
  Future<void> initHttpService() async {
    host = ApiConstants.geminiBaseUrl;
    //initialize dio
    baseOptions = BaseOptions(
        baseUrl: host!,
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
        validateStatus: (status) {
          return status! <= 500;
        });
    dio = Dio(baseOptions);
  }

  //get method
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters,
        CancelToken? token,
        bool useCSRFToken = false}) async {
    String uri = "$host$url";
    print(uri);
    return dio!.get(
      uri,
      options: Options(
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        }
      ),
      queryParameters: queryParameters,
    );
  }



  //post method
  Future<Response> post(String url, {dynamic body, CancelToken? token}) async {
    String uri = "$host$url";
    print(uri);
    return dio!.post(
      uri,
      data: body,
      cancelToken: token,
      options: Options(
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        },
      ),
    );
  }

  //patch from database
  Future<Response> patch(String url, body, {CancelToken? token}) async {
    String uri = "$host$url";
    print(uri);
    return dio!.patch(
      uri,
      data: body,
      options: Options(
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        }
      ),
    );
  }

  // put into database
  Future<Response> put(String url,
      {Map<String, dynamic>? queryParameters,
        dynamic body,
        CancelToken? token}) async {
    String uri = "$host$url";
    print(uri);
    return dio!.put(uri,
        data: body,
        options: Options(
          headers: {
            HttpHeaders.acceptHeader: "application/json",
          },
        ),
        queryParameters: queryParameters);
  }

  //detele from database
  Future<Response> delete(String url,
      {dynamic body, CancelToken? token}) async {
    String uri = "$host$url";
    print(uri);
    return dio!.delete(
      uri,
      data: body,
      options: Options(
        headers: {
          HttpHeaders.acceptHeader: "application/json",
        },
      ),
    );
  }
}


