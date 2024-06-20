import 'dart:convert';

import 'package:e_commerce/common/apis/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/search_blocs.dart';
import 'bloc/search_events.dart';

class MySearchController {
  late BuildContext context;

  MySearchController({required this.context});

  void init() {
    asyncLoadRecommendedData();
  }

  Future<void> asyncLoadRecommendedData() async {
    var result = await UserAPI.recommendedProductList();
    if (result != null) {
      context.read<SearchBlocs>().add(TriggerSearchEvents(result));
      print('load data');
    } else {
      toastInfo(msg: 'Internet error');
    }
  }

  Future<void> asyncLoadSearchData(String item) async {
    var result = await UserAPI.searchProducts(item);
    if (result != null) {
      context.read<SearchBlocs>().add(TriggerSearchEvents(result));
      print('${jsonEncode(result)}');
    } else {
      toastInfo(msg: 'Internet error');
    }
  }
}
