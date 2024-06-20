import 'package:e_commerce/pages/product_detail/product_detail_controller.dart';
import 'package:e_commerce/pages/product_detail/widgets/course_detail_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/widgets/base_text_widget.dart';
import 'bloc/product_detail_blocs.dart';
import 'bloc/product_detail_states.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late ProductDetailController _productDetailController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(seconds: 0), () {
      _productDetailController = ProductDetailController(context: context);
      _productDetailController.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    print("------ my build method -------");
    return BlocBuilder<ProductDetailBloc, ProductDetailStates>(
      builder: (context, state) {
        //  print('course id ${state.courseItem!.id}');
        return state.productResponse == null
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              )
            : Container(
                color: Colors.white,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: buildAppBar("Product detail"),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //first big image
                                thumbNail(state.productResponse!.id),
                                SizedBox(
                                  height: 15.h,
                                ),
                                //three buttons or menus
                                menuView(context, state),
                                SizedBox(
                                  height: 15.h,
                                ),
                                //product name
                                productName(state.productResponse!.name),
                                SizedBox(
                                  height: 15.h,
                                ),
                                //product price
                                productPrice(state.productResponse!.price),
                                SizedBox(
                                  height: 15.h,
                                ),
                                //product quantity
                                productQuantity(
                                    state.productResponse!.availableQuantity),
                                SizedBox(
                                  height: 15.h,
                                ),
                                productCategory(
                                    state.productResponse!.categoryName,
                                    state.productResponse!.categoryDescription),
                                SizedBox(
                                  height: 15.h,
                                ),
                                //product description title
                                reusableText("Product Description"),
                                SizedBox(
                                  height: 15.h,
                                ),
                                //course description
                                descriptionText(state
                                    .productResponse!.description
                                    .toString()),
                                SizedBox(
                                  height: 20.h,
                                ),
                                //course buy button
                                GestureDetector(
                                  onTap: () {
                                    //_courseDetailController.goBuy(state.courseItem!.id);
                                  },
                                  child: appPrimaryButton("Go buy"),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                //course summary title
                                productSummaryTitle(),

                                //course summary in list
                                productSummaryView(context),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
