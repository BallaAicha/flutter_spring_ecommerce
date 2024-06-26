import 'package:e_commerce/pages/cart/widgets/widget_panier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),

          body: Column(
            children: [
              Padding( padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 25.w),
                child: Column(
                  children: [
                    panierProductList(),
                    panierProductList(),
                    panierProductList()

                  ],
                )

              )

            ],
          )
        ),
      ),
    );
  }
}
