import 'package:flutter/cupertino.dart';

import '../../common/apis/user_api.dart';
import '../../common/entities/OrderRequestEntity.dart';
import '../../common/entities/OrderResponseEntity.dart';


class OrderControlller{
  Future<int> addOrder(OrderRequestEntity request) async {
    return await UserAPI.passerCommande(request);
  }

  Future<List<OrderResponseEntity>> getOrders(String customerId) async {
    return await UserAPI.getOrders(customerId);
  }





}