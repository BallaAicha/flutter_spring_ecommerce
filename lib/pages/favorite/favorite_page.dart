

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/apis/user_api.dart';
import '../../common/entities/FavorisResponse.dart';
import '../../global.dart';
import 'bloc/FavoriteBloc.dart';
import 'bloc/FavoriteEvent.dart';
import 'bloc/FavoriteState.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key); // Add customerId to the constructor


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
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context); // Move this here
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
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: state.favorisResponses.length,
              itemBuilder: (context, index) {
                return buildFavoriteList(state.favorisResponses[index]);
              },
            );
          } else if (state is FavoriteError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget buildFavoriteList(FavorisResponse favorisResponse) {
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
                          onPressed: () {
                            // Handle cart icon press
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
