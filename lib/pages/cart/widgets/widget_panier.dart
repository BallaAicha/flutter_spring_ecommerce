import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

Widget panierProductList() {
  return Container(
    width: 335.w,
    height: 100.h,
    margin: EdgeInsets.only(top: 10.h),
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1))
        ]),
    child: Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.h),
                      image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage("assets/icons/image_1.png")
                      )
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
                    listItemContainer("Product a large qualité"),
                    listItemContainer(
                        "offert Par Ousmane",
                        fontSize: 10,
                        color: AppColors.primaryThirdElementText,
                        fontWeight: FontWeight.normal)
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {},
            ),
            Text('1', style: TextStyle(fontSize: 20.sp)),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
}

Widget listItemContainer(
    String name,
    {double fontSize = 13,
      Color color = AppColors.primaryText,
      fontWeight = FontWeight.bold}) {
  return Container(
    width: 225.w,
    margin: EdgeInsets.only(left: 6.w),
    padding: EdgeInsets.symmetric(horizontal: 10.w), // Add some padding
    child: Text(
      name,
      overflow: TextOverflow.ellipsis, // Use ellipsis to handle overflow
      maxLines: 1,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: fontWeight), // Use the fontWeight parameter
    ),
  );
}


