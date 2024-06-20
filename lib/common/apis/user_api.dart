import 'dart:convert';
import '../entities/FavorisRequest.dart';
import '../entities/FavorisResponse.dart';
import '../entities/LoginRequestEntity.dart';
import '../entities/LoginResponseEntity.dart';
import '../entities/ProductResponse.dart';
import '../utils/http_util.dart';
import '../values/constant.dart';
class UserAPI {
  static Future<LoginResponseEntity?> login(
      {LoginRequestEntity? params}) async {
    //response = response.data after the post method returns
    var id = await HttpUtil().post(
        '${AppConstants.SERVER_API_URL_BACKEND}/customers',
        mydata: params?.toJson()
    );

    if (id != null) {
      return LoginResponseEntity.fromJson({'id': id});
    } else {
      return null;
    }
  }

  static Future<List<ProductResponse>?> getProducts() async {
    var response = await HttpUtil().get(
        '${AppConstants.SERVER_API_URL_BACKEND}/products');

    if (response != null) {
      List<ProductResponse> products = [];
      for (var item in response) {
        products.add(ProductResponse.fromJson(item));
      }
      return products;
    } else {
      return null;
    }
  }

  static Future<List<int>> getProductImage(int productId) async {
    var response = await HttpUtil().get(
        '${AppConstants.SERVER_API_URL_BACKEND}/products/getImagesProd/$productId');

    if (response != null && response is List && response.isNotEmpty &&
        response[0] is Map<String, dynamic> &&
        response[0].containsKey('image')) {
      String base64Image = response[0]['image'];
      return base64Decode(base64Image).toList();
    } else {
      return List<int>.empty();
    }
  }

  static Future<ProductResponse?> getProductDetail(int productId) async {
    var response = await HttpUtil().get('${AppConstants.SERVER_API_URL_BACKEND}/products/$productId');

    if (response != null) {
      return ProductResponse.fromJson(response);
    } else {
      return null;
    }
  }

  static Future<List<ProductResponse>?> searchProducts(String name) async {
    var response = await HttpUtil().get(
        '${AppConstants.SERVER_API_URL_BACKEND}/products/name/$name');

    if (response != null) {
      List<ProductResponse> products = [];
      for (var item in response) {
        products.add(ProductResponse.fromJson(item));
      }
      return products;
    } else {
      return null;
    }
  }

  static Future<List<ProductResponse>?> recommendedProductList() async {
    var response = await HttpUtil().get(
        '${AppConstants.SERVER_API_URL_BACKEND}/products/firstProductPerCategory');

    if (response != null) {
      List<ProductResponse> products = [];
      for (var item in response) {
        products.add(ProductResponse.fromJson(item));
      }
      return products;
    } else {
      return null;
    }
  }

  static Future<FavorisResponse> addFavoris(FavorisRequest request) async {
    var response = await HttpUtil().post(
      '${AppConstants.SERVER_API_URL_BACKEND}/products/favoris',
      mydata: request.toJson(),
    );

    if (response is int) {
      // Handle the case where the response is an integer
      return FavorisResponse(id: response, productList: []);
    } else if (response is Map<String, dynamic>) {
      // Handle the case where the response is a JSON object
      return FavorisResponse.fromJson(response);
    } else {
      // Handle any other cases
      return FavorisResponse(id: 0, productList: []);
    }
  }

  static Future<List<FavorisResponse>> getFavoris() async {
    var response = await HttpUtil().get(
        '${AppConstants.SERVER_API_URL_BACKEND}/products/favoris');
    if (response != null) {
      List jsonResponse = response as List;
      return jsonResponse.map((item) => FavorisResponse.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load favoris');
    }
  }










}

