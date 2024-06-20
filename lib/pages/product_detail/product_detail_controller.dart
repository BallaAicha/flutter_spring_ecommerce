import 'package:e_commerce/common/apis/user_api.dart';
import 'package:e_commerce/pages/product_detail/bloc/product_detail_blocs.dart';
import 'package:e_commerce/pages/product_detail/bloc/product_detail_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductDetailController {
  final BuildContext context;

  ProductDetailController({required this.context});

  void init() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadProductData(args["id"]);
  }

  asyncLoadProductData(int? id) async {
    var result = await UserAPI.getProductDetail(id!);

    if (result != null) {
      if (context.mounted) {
        print('---------context is ready------');
        context.read<ProductDetailBloc>().add(TriggerProductDetail(result));
      } else {
        print('-------context is not available-------');
      }
    } else {
      EasyLoading.showError(
          "Something went wrong and check the log in the laravel.log");
    }
  }
}
