// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:e_commerce/pages/orders/bloc/OrderBloc.dart';
// import 'package:e_commerce/pages/orders/bloc/OrderEvent.dart';
// import 'package:e_commerce/pages/orders/bloc/OrderState.dart';
// import 'package:e_commerce/global.dart';
//
// import '../../common/entities/OrderResponseEntity.dart';
//
// class OrdersList extends StatefulWidget {
//   const OrdersList({Key? key}) : super(key: key);
//
//   @override
//   State<OrdersList> createState() => _OrdersListState();
// }
//
// class _OrdersListState extends State<OrdersList> with SingleTickerProviderStateMixin {
//   late OrderBloc orderBloc;
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     orderBloc = BlocProvider.of<OrderBloc>(context);
//     String? accessToken = Global.storageService.getUserToken();
//     if (accessToken != null) {
//       Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken);
//       String customerId = tokenInfo["sub"];
//       orderBloc.add(LoadOrdersEvent(customerId));
//     }
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Orders'),
//       ),
//       body: BlocBuilder<OrderBloc, OrderState>(
//         builder: (context, state) {
//           if (state is OrderLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is OrderLoaded) {
//             return ListView.builder(
//               padding: EdgeInsets.all(10),
//               itemCount: state.orders.length,
//               itemBuilder: (context, index) {
//                 return buildOrderList(state.orders[index]);
//               },
//             );
//           } else if (state is OrderError) {
//             return Center(child: Text(state.error));
//           } else {
//             return const Center(child: Text('Unknown state'));
//           }
//         },
//       ),
//     );
//   }
//
//   // Widget buildOrderList(OrderResponseEntity order) {
//   //   return ScaleTransition(
//   //     scale: Tween(begin: 0.8, end: 1.0).animate(
//   //       CurvedAnimation(
//   //         parent: _controller..forward(),
//   //         curve: Curves.easeOut,
//   //       ),
//   //     ),
//   //     child: Card(
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(15),
//   //       ),
//   //       margin: EdgeInsets.all(10),
//   //       child: ListTile(
//   //         title: Text('Order ID: ${order.id}'),
//   //         subtitle: Text('Reference: ${order.reference}\nPayment Method: ${order.paymentMethod}\nCustomer ID: ${order.customerId}'),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//
//
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:e_commerce/pages/orders/bloc/OrderBloc.dart';
import 'package:e_commerce/pages/orders/bloc/OrderEvent.dart';
import 'package:e_commerce/pages/orders/bloc/OrderState.dart';
import 'package:e_commerce/global.dart';
import '../../common/entities/OrderResponseEntity.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> with SingleTickerProviderStateMixin {
  late OrderBloc orderBloc;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    orderBloc = BlocProvider.of<OrderBloc>(context);
    String? accessToken = Global.storageService.getUserToken();
    if (accessToken != null) {
      Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken);
      String customerId = tokenInfo["sub"];
      orderBloc.add(LoadOrdersEvent(customerId));
    }
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget menuView() {
    return Container(
      width: 325.w,
      margin: EdgeInsets.only(
        top: 15.h,
        bottom: 8.h,
      ),
      child: Text(
        "Your Orders",
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildOrderListItem(OrderLoaded state) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.orders.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 325.w,
            height: 130.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                // Navigation logic to order detail page
              },
              child: Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Order details
                    Flexible(

                      child: Column(

                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            'Order ID: ${state.orders[index].id}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),

                          Text(
                            'Reference: ${state.orders[index].reference}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Payment Method: ${state.orders[index].paymentMethod}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Order status
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            'Total Price: 10000',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 55.w,
                          child: Text(
                            'Success',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              menuView(),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderLoaded) {
                    return buildOrderListItem(state);
                  } else if (state is OrderError) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(child: Text('Unknown state'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

