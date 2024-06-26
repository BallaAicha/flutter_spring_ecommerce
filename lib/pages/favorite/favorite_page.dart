import 'dart:typed_data';
import 'package:e_commerce/pages/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/apis/user_api.dart';
import '../../common/entities/CartRequest.dart';
import '../../common/entities/FavorisResponse.dart';
import '../../common/entities/Product.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/FavoriteBloc.dart';
import 'bloc/FavoriteEvent.dart';
import 'bloc/FavoriteState.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with SingleTickerProviderStateMixin {
  late FavoriteBloc favoriteBloc;
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
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    String? accessToken = Global.storageService.getUserToken();
    if (accessToken != null) {
      Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken);
      String customerId = tokenInfo["sub"];
      favoriteBloc.add(LoadFavoritesEvent(customerId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        actions: [
          IconButton(
            icon: Icon(Ionicons.cart),
            onPressed: () {
              // Handle cart icon press
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            if (state.favorisResponses.isEmpty) {
              return Center(child: Text('No favorites yet', style: TextStyle(fontSize: 18.sp, color: Colors.grey)));
            }
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: state.favorisResponses.length,
              itemBuilder: (context, index) {
                return buildFavoriteList(state.favorisResponses[index], context);
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.error, style: TextStyle(fontSize: 18.sp, color: Colors.red)));
          } else {
            return Center(child: Text('Unknown state', style: TextStyle(fontSize: 18.sp, color: Colors.grey)));
          }
        },
      ),
    );
  }

  Widget buildFavoriteList(FavorisResponse favorisResponse, BuildContext context) {
    return Column(
      children: favorisResponse.productList.map((product) {
        if (product == null) {
          return const SizedBox.shrink();
        }

        return FutureBuilder<List<int>>(
          future: UserAPI.getProductImage(product.id),
          builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ScaleTransition(
                scale: Tween(begin: 0.8, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller..forward(),
                    curve: Curves.easeOut,
                  ),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.memory(Uint8List.fromList(snapshot.data!)),
                    title: Text(product.name),
                    subtitle: Text(product.categoryName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Ionicons.cart),
                          onPressed: () async {
                            final cartController = CartController();
                            if (product.id != null) {
                              print('Product IDCart: ${product.id}');
                              String? accessToken = Global.storageService.getUserToken();
                              Map<String, dynamic> tokenInfo = JwtDecoder.decode(accessToken!);
                              String customerId = tokenInfo["sub"];
                              print("Customer ID: $customerId");
                              var cartRequest = CartRequest(
                                id: product.id,
                                productList: [Product(id: product.id)],
                                customerId: customerId,
                              );
                              print('Product ID: ${product.id}');
                              var response = await cartController.addCart(cartRequest);
                              if (response.id != 0) {
                                toastInfo(msg: 'Product added to cart');
                              } else {
                                toastInfo(msg: 'Failed to add product to cart', backgroundColor: Colors.red);
                              }
                            } else {
                              print('Product ID is null');
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Ionicons.heart_dislike_outline),
                          onPressed: () {
                            // Handle dislike press
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
