import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../global.dart';
import '../values/constant.dart';


class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: AppConstants.SERVER_API_URL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 30),
        headers: {},
        contentType: "application/json; charset=utf-8", // Corrected here
        responseType: ResponseType.json);
    dio = Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<String?> authenticate(String username, String password) async {
    var url = Uri.parse(AppConstants.SERVER_API_URL);
    var response = await dio.post(
      url.toString(),
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {
        'grant_type': 'password',
        'client_id': 'ecommerce',
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var data = response.data; // No need to use jsonDecode here
      return data['access_token'];
    } else {
      print('Failed to authenticate. Status code: ${response.statusCode}');
      print('Response body: ${response.data}');
      return null;
    }
  }





  Future post(
      String path,
      {dynamic mydata,
        Map<String, dynamic>? queryParameters,
        Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.post(path,
        data: mydata,
        queryParameters: queryParameters,
        options: requestOptions);

    // Check if response.data is not null and contains 'id' before accessing 'id'
    if (response.data != null && response.data['id'] != null) {
      return response.data['id'];
    } else {
      return null;
    }
  }

  Future get(
      String path,
      {Map<String, dynamic>? queryParameters,
        Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.get(path,
        queryParameters: queryParameters,
        options: requestOptions);

    if (response.data != null) {
      return response.data;
    } else {
      return null;
    }
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }
}


