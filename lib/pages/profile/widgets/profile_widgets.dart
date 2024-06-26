import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../../home/home_controller.dart';

AppBar buildAppbar() {
  return AppBar(
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 18.w,
              height: 12.h,
              child: Image.asset("assets/icons/menu.png")),
          reusableText("Profile"),
          SizedBox(
              width: 24.w,
              height: 24.h,
              child: Image.asset("assets/icons/more-vertical.png")),
        ],
      ),
    ),
  );
}

//profile icon and edit button
Widget profileIconAndEditButton() {
  return Container(
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.only(right: 6.w),
    width: 80.w,
    height: 80.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        image: const DecorationImage(
            image: AssetImage("assets/icons/headpic.png"))),
    child: Image(
      width: 25.w,
      height: 25.h,
      image: const AssetImage("assets/icons/edit_3.png"),
    ),
  );
}

//setting sections buttons
var imagesInfo = <String, String>{
  "Settings": "settings.png",
  "Payment details": "credit-card.png",
  "Love": "heart(1).png",
  "Reminders": "cube.png"
};

Widget buildListView(BuildContext context) {
  return Column(
    children: [
      ...List.generate(
        imagesInfo.length,
        (index) => GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.of(context).pushNamed("/settings");
            } else if (index == 1) {
               Navigator.of(context).pushNamed("/orders");
            }



          },
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(7.0.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      color: AppColors.primaryElement),
                  child: Image.asset(
                      "assets/icons/${imagesInfo.values.elementAt(index)}"),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(imagesInfo.keys.elementAt(index),
                    style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp))
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Widget buildRowView(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 20.h, left: 25.w, right: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _rowView("heart(1).png", "My Favorites ", () {}),
          _rowView("profile_book.png", "Buy Products", () {
            //Navigator.of(context).pushNamed(AppRoutes.BUY_COURSES);
          }),
          _rowView("profile_star.png", "4.9", () {}),
        ],
      ));
}

Widget _rowView(String iconPath, String itemName, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
      width: 100.w,
      decoration: BoxDecoration(
          color: AppColors.primaryElement,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(color: AppColors.primaryElement)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 20.w,
              height: 20.h,
              child: Image.asset("assets/icons/$iconPath")),
          Container(
              margin: EdgeInsets.only(top: 5.h),
              child: reusableText(itemName,
                  color: AppColors.primaryElementText,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold))
        ],
      ),
    ),
  );
}

Widget buildProfileName(BuildContext context) {
  String userName = HomeController(context: context).getUserName();
  return userName.isEmpty
      ? Container(
          child: reusableText("No name found"),
        )
      : Container(
          padding: EdgeInsets.only(left: 50.w, right: 50.w),
          margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
          child: Text(
            userName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.primarySecondaryElementText,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          ),
        );
}
