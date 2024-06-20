import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/entities/FavorisRequest.dart';
import '../../../common/entities/ProductRequest.dart';
import '../favorite_controller.dart';
import 'FavoriteEvent.dart';
import 'FavoriteState.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteController favoriteController;

  FavoriteBloc(this.favoriteController) : super(FavoriteInitial()) {
    on<AddToFavoritesEvent>(_addToFavorites);
    on<LoadFavoritesEvent>(_loadFavorites);
  }

  void _addToFavorites(
      AddToFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      var favorisRequest = FavorisRequest(
          id: event.productId,
          productList: [ProductRequest(id: event.productId)]);
      var response = await favoriteController.addFavoris(favorisRequest);
      emit(FavoriteLoaded([response]));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  void _loadFavorites(
      LoadFavoritesEvent event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      var response = await favoriteController.getFavoris();
      emit(FavoriteLoaded(response));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
