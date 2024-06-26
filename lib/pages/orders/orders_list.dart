import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 15.h,
        bottom: 8.h,
      ),
      child: Text(
        "Your Orders",
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildOrderListItem(OrderLoaded state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.orders.length,
      itemBuilder: (context, index) {
        return ScaleTransition(
          scale: Tween(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller..forward(),
              curve: Curves.easeOut,
            ),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.w),
            ),
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: ListTile(
              title: Text('Order ID: ${state.orders[index].id}'),
              subtitle: Text(
                'Reference: ${state.orders[index].reference}\n'
                    'Payment Method: ${state.orders[index].paymentMethod}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Price: 1000 DH',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Status:  Sucess',
                    style: TextStyle(

                    color: Colors.green,

                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Handle order item tap
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            menuView(),
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderLoaded) {
                    return state.orders.isEmpty
                        ? Center(
                      child: Text(
                        'No orders yet',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    )
                        : buildOrderListItem(state);
                  } else if (state is OrderError) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.red,
                        ),
                      ),
                    );
                  } else {
                    return  Center(
                      child: Text(
                        'Unknown state',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
