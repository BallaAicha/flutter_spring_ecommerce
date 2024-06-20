import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/apis/user_api.dart';
import '../../../common/values/colors.dart';

import '../../../common/widgets/base_text_widget.dart';
import '../bloc/search_states.dart';

Widget searchList(SearchStates state) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: state.productItem.length,
      itemBuilder: (context, index) {
        return FutureBuilder<List<int>>(
          future: UserAPI.getProductImage(state.productItem[index].id),
          builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show a loading spinner while waiting
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Show error message if something went wrong
            } else {
              return Container(
                margin: EdgeInsets.only(top: 10.h),
                width: 325.w,
                height: 80.h,
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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/product_detail", arguments: {
                      "id": state.productItem[index].id,
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //for image and the text
                      Row(
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.h),
                                image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: MemoryImage(
                                        Uint8List.fromList(snapshot.data!)))),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //list item title
                              listItemContainer(
                                  state.productItem[index].name.toString()),
                              //list item description
                              listItemContainer(
                                  "${state.productItem[index].description}",
                                  fontSize: 10,
                                  color: AppColors.primaryThirdElementText,
                                  fontWeight: FontWeight.normal)
                            ],
                          )
                        ],
                      ),
                      //for showing the right arrow
                      Container(
                        child: Image(
                          height: 24.h,
                          width: 24.h,
                          image: AssetImage("assets/icons/arrow_right.png"),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        );
      });
}
