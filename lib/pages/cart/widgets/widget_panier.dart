import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:e_commerce/pages/cart/bloc/carts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/apis/user_api.dart';
import '../../../common/entities/ProductResponse.dart';
import '../../../common/values/colors.dart';

Widget panierProductList(int productId, CartState state) {
  return FutureBuilder<List<int>>(
    future: UserAPI.getProductImage(productId),
    builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        if (snapshot.hasData && snapshot.data != null) {
          if (state is CartLoaded) {
            ProductResponse? product;
            for (var cart in state.cartResponses) {
              product = cart.productList.firstWhereOrNull((product) => product.id == productId);
              if (product != null) {
                break;
              }
            }

            if (product != null) {
              return Container(
                width: 335.w,
                height: 100.h,
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.h),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: MemoryImage(Uint8List.fromList(snapshot.data!)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listItemContainer(product.name),
                          listItemContainer(
                            product.categoryName,
                            fontSize: 15,
                            color: AppColors.primaryThirdElementText,
                            fontWeight: FontWeight.normal,
                          ),
                          listItemContainer(
                            product.price.toString(),
                            fontSize: 18,
                            color: AppColors.primaryElementBg,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.grey),
                              onPressed: () {},
                              color: Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.grey),
                              onPressed: () {},
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text('No matching product found');
            }
          } else {
            return Container();
          }
        } else {
          return Text('No data available');
        }
      }
    },
  );
}

Widget listItemContainer(String name,
    {double fontSize = 13,
      Color color = AppColors.primaryText,
      FontWeight fontWeight = FontWeight.bold}) {
  return Container(
    width: 225.w,
    margin: EdgeInsets.only(left: 6.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    child: Text(
      name,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    ),
  );
}
