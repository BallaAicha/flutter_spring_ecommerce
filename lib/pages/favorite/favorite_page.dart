import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

import '../../common/apis/user_api.dart';
import '../../common/entities/FavorisResponse.dart';
import 'bloc/FavoriteBloc.dart';
import 'bloc/FavoriteEvent.dart';
import 'bloc/FavoriteState.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoriteBloc favoriteBloc;

  @override
  void initState() {
    super.initState();
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context); //appel du bloc favorite
    favoriteBloc.add(LoadFavoritesEvent()); //appel de la methode loadFavorites
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return buildFavoriteList(state.favorisResponses[index]);
                    },
                    childCount: state.favorisResponses.length,
                  ),
                ),
              ],
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
              //verifie si la connection est en cours cad si on attend une reponse
              return CircularProgressIndicator(); // Show a loading spinner while waiting
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Show error message if something went wrong
            } else {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        0.08, // Reduced height
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          spreadRadius: 5,
                          blurRadius: 0.3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // Removed Expanded
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
                            Padding(
                              padding: EdgeInsets.only(top: 12.h, left: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        product.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        product.categoryName,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Flexible(
                                    child: FittedBox(
                                      child: Text(
                                        '\$${product.price}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Ionicons.heart_dislike_outline,
                            ),
                          ),
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
