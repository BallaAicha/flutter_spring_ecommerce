import 'dart:typed_data';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/apis/user_api.dart';
import '../../../common/entities/ProductResponse.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../bloc/home_page_blocs.dart';
import '../bloc/home_page_events.dart';
import '../bloc/home_page_states.dart';

AppBar buildAppBarr(String avatar) {
  return AppBar(
      title: Container(
    margin: EdgeInsets.only(left: 7.w, right: 7.w),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),
          GestureDetector(
              child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/avatar-1.png"))),
          )),
        ]),
  ));
}

//reusable big text widget
Widget homePageText(String text,
    {Color color = AppColors.primaryText, int top = 20}) {
  return Container(
    margin: EdgeInsets.only(top: top.h),
    child: Text(
      text,
      style:
          TextStyle(color: color, fontSize: 24.sp, fontWeight: FontWeight.bold),
    ),
  );
}

//for sliders view
Widget slidersView(BuildContext context, HomePageStates state) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 20.h),
        width: 325.w,
        height: 160.h,
        child: PageView(
          onPageChanged: (value) {
            print("my value is");
            print(value.toString());
            context.read<HomePageBlocs>().add(HomePageDots(value));
          },
          children: [
            _slidersContainer(path: "assets/Mechanical-Keyboard1.webp"),
            _slidersContainer(path: "assets/keyboard.jpg"),
            _slidersContainer(path: "assets/pc.jpeg")
          ],
        ),
      ),
      Container(
        child: DotsIndicator(
          dotsCount: 3,
          position: state.index,
          decorator: DotsDecorator(
              color: AppColors.primaryThirdElementText,
              activeColor: AppColors.primaryElement,
              size: const Size.square(5.0),
              activeSize: const Size(17.0, 5.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ),
      )
    ],
  );
}

// sliders widget
Widget _slidersContainer({String path = "assets/icons/art.png"}) {
  return Container(
    width: 325.w,
    height: 160.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.h)),
        image: DecorationImage(fit: BoxFit.fill, image: AssetImage(path))),
  );
}
//menu view for showing items

Widget menuView() {
  return Column(
    children: [
      Container(
          width: 325.w,
          margin: EdgeInsets.only(top: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              reusableText("Choose your product"),
              GestureDetector(
                  child: reusableText("See all",
                      color: AppColors.primaryThirdElementText, fontSize: 10)),
            ],
          )),
      Container(
        margin: EdgeInsets.only(top: 20.w),
        child: Row(
          children: [
            _reusableMenuText("All"),
            _reusableMenuText("Popular",
                textColor: AppColors.primaryThirdElementText,
                backGroundColor: Colors.white),
            _reusableMenuText("Newest",
                textColor: AppColors.primaryThirdElementText,
                backGroundColor: Colors.white),
          ],
        ),
      )
    ],
  );
}

//for the mnue buttons, reusbale text
Widget _reusableMenuText(String menuText,
    {Color textColor = AppColors.primaryElementText,
    Color backGroundColor = AppColors.primaryElement}) {
  return Container(
    margin: EdgeInsets.only(right: 20.w),
    decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(7.w),
        border: Border.all(color: backGroundColor)),
    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
    child: reusableText(menuText,
        color: textColor, fontWeight: FontWeight.normal, fontSize: 11),
  );
}

// // Pour la vue de la grille de produits
// Widget productGrid(ProductResponse product) {
//
//   return Container(
//     padding: EdgeInsets.all(12.w),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.w),
//         image: DecorationImage(
//           fit: BoxFit.fill,
//           image: NetworkImage("http://192.168.1.94:8222/api/v1/products/getImagesProd/${product.id}"),
//         )),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           product.name,
//           maxLines: 1,
//           overflow: TextOverflow.fade,
//           textAlign: TextAlign.left,
//           softWrap: false,
//           style: TextStyle(
//               color: AppColors.primaryElementText,
//               fontWeight: FontWeight.bold,
//               fontSize: 11.sp),
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         Text(
//           product.description,
//           maxLines: 1,
//           overflow: TextOverflow.fade,
//           textAlign: TextAlign.left,
//           softWrap: false,
//           style: TextStyle(
//               color: AppColors.primaryFourthElementText,
//               fontWeight: FontWeight.normal,
//               fontSize: 8.sp),
//         )
//       ],
//     ),
//   );
// }

Widget productGrid(ProductResponse product) {
  return FutureBuilder<List<int>>(
    future: UserAPI.getProductImage(product.id),
    builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Show a loading spinner while waiting
      } else if (snapshot.hasError) {
        return Text(
            'Error: ${snapshot.error}'); // Show error message if something went wrong
      } else {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: MemoryImage(Uint8List.fromList(snapshot.data!)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left,
                softWrap: false,
                style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                product.description,
                maxLines: 1,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left,
                softWrap: false,
                style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 8.sp),
              )
            ],
          ),
        );
      }
    },
  );
}
