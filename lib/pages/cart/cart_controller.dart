import 'dart:async';

import 'package:e_commerce/common/apis/user_api.dart';
import 'package:e_commerce/common/entities/CartRequest.dart';


import '../../common/entities/CartResponse.dart';

class CartController{
  Future<CartResponse> addCart(CartRequest request) async{
    return await UserAPI.addCart(request);}
  Future<List<CartResponse>> getCartsByCustomer(String customerId) async{
    return await UserAPI.getCarts(customerId);
  }
}