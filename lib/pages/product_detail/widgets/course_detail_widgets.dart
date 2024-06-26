import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../common/apis/user_api.dart';
import '../../../common/entities/FavorisRequest.dart';
import '../../../common/entities/Product.dart';
import '../../../common/entities/ProductRequest.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../../../global.dart';
import '../../favorite/favorite_controller.dart';
import '../bloc/product_detail_states.dart';

// Widget thumbNail(int productId) {
//   return FutureBuilder<List<int>>(
//     future: UserAPI.getProductImage(productId),
//     builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();  // Show a loading spinner while waiting
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');  // Show error message if something went wrong
//       } else {
//         return Container(
//           width: 325.w,
//           height: 200.h,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.fitWidth,
//               image: MemoryImage(Uint8List.fromList(snapshot.data!)),
//             ),
//           ),
//         );
//       }
//     },
//   );
// }
Widget thumbNail(int productId) {
  final favoriteController = FavoriteController();
  return FutureBuilder<List<int>>(
    future: UserAPI.getProductImage(productId),
    builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Show a loading spinner while waiting
      } else if (snapshot.hasError) {
        return Text(
            'Error: ${snapshot.error}'); // Show error message if something went wrong
      } else {
        return Stack(
          children: [
            Container(
              width: 325.w,
              height: 200.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: MemoryImage(Uint8List.fromList(snapshot.data!)),
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              right: 10.w,
              child: IconButton(
                icon: Icon(
                    size: 30.w, Icons.favorite_border, color: Colors.black),
                onPressed: () async {
                  print('Product IDDDDDD: $productId');
                  if (productId != null) {
                    String? accessToken = Global.storageService.getUserToken();
                    Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken!);
                    String customerId = tokenInfo["sub"]; // Get the customerId from the token
                    // Logs pour vérifier les valeurs
                    print("Customer ID: $customerId");
                    var favorisRequest = FavorisRequest(
                        id: productId,
                        productList: [Product(id: productId)],
                        customerId: customerId);
                    print('Product ID: $productId');
                    var response =
                    await favoriteController.addFavoris(favorisRequest);
                    if (response.id != 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content:
                            Text('Your product has been added successfully.'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    print('Product ID is null');
                  }
                },
              ),
            ),
          ],
        );
      }
    },
  );
}

Widget menuView(BuildContext context, ProductDetailStates state) {
  return SizedBox(
    width: 325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.circular(7.w),
                  border: Border.all(color: AppColors.primaryElement)),
              child: reusableText("Author Page",
                  color: AppColors.primaryElementText,
                  fontWeight: FontWeight.normal,
                  fontSize: 10.sp)),
        ),
        _iconAndNum("assets/icons/people.png", 0),
        _iconAndNum("assets/icons/star.png", 0)
      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(iconPath),
          width: 20.w,
          height: 20.h,
        ),
        reusableText(num.toString(),
            color: AppColors.primaryThirdElementText,
            fontSize: 11.sp,
            fontWeight: FontWeight.normal)
      ],
    ),
  );
}

Widget descriptionText(String description) {
  return reusableText(description,
      color: AppColors.primaryThirdElementText,
      fontWeight: FontWeight.normal,
      fontSize: 11.sp);
}

Widget productName(String name) {
  return reusableText(name,
      color: AppColors.primaryThirdElementText,
      fontWeight: FontWeight.bold,
      fontSize: 20.sp);
}

Widget productPrice(double price) {
  return reusableText("\$${price.toStringAsFixed(2)}",
      color: AppColors.primaryThirdElementText,
      fontWeight: FontWeight.normal,
      fontSize: 16.sp);
}

Widget productQuantity(double quantity) {
  return reusableText("Available Quantity: ${quantity.toStringAsFixed(0)}",
      color: AppColors.primaryThirdElementText,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp);
}

Widget productCategory(String categoryName, String categoryDescription) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      reusableText(categoryName,
          color: AppColors.primaryThirdElementText,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp),
      reusableText(categoryDescription,
          color: AppColors.primaryThirdElementText,
          fontWeight: FontWeight.normal,
          fontSize: 14.sp),
    ],
  );
}

Widget productSummaryTitle() {
  return reusableText("The Services Includes", fontSize: 14.sp);
}

Widget productSummaryView(BuildContext context) {
//setting sections buttons
  var imagesInfo = <String, String>{
    "Garantie 1 mois": "Guarantee.png",
    "Haute qualité": "quality.png",
    "Livraison rapide": "Delivery.png",
    "Satisfait ou remboursé": "check.png"
  };

  return Column(
    children: [
      ...List.generate(
        imagesInfo.length,
            (index) => GestureDetector(
          onTap: () => null,
          child: Container(
            margin: EdgeInsets.only(top: 15.h),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.all(7.0.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: AppColors.primaryElement),
                  child: Image.asset(
                    "assets/icons/${imagesInfo.values.elementAt(index)}",
                    width: 30.w,
                    height: 30.h,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(imagesInfo.keys.elementAt(index),
                    style: TextStyle(
                        color: AppColors.primarySecondaryElementText,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp))
              ],
            ),
          ),
        ),
      )
    ],
  );
}