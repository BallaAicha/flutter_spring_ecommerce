import 'package:e_commerce/pages/cart/bloc/carts_bloc.dart';
import 'package:e_commerce/pages/cart/widgets/widget_panier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../common/entities/CartResponse.dart';
import '../../global.dart';
import 'bloc/carts_event.dart';
import 'bloc/carts_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  late CartBloc cartBloc;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cartBloc = BlocProvider.of<CartBloc>(context);
    String? accessToken = Global.storageService.getUserToken();
    if (accessToken != null) {
      Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken);
      String customerId = tokenInfo["sub"];
      cartBloc.add(LoadCartsEvent(customerId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
          ),
          body: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CartLoaded) {
                if (state.cartResponses.isEmpty) {
                  return Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 18.sp, color: Colors.grey)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: state.cartResponses.length,
                  itemBuilder: (context, index) {
                    return buildCartList(state.cartResponses[index], context);
                  },
                );
              } else if (state is CartError) {
                return Center(child: Text(state.error, style: TextStyle(fontSize: 18.sp, color: Colors.red)));
              } else if (state is CartInitial) {
                return Center(child: Text('Cart is empty', style: TextStyle(fontSize: 18.sp, color: Colors.grey)));
              } else {
                return  Center(child: Text('Unknown state', style: TextStyle(fontSize: 18.sp, color: Colors.grey)));
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget buildCartList(CartResponse cartResponse, BuildContext context) {
  return Column(
    children: cartResponse.productList.map((product) {
      if (product == null) {
        return const SizedBox.shrink();
      }

      int productId = product.id;
      CartState state = BlocProvider.of<CartBloc>(context).state;
      return panierProductList(productId, state);
    }).toList(),
  );
}
