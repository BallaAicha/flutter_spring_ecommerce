import '../../../common/entities/FavorisResponse.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavorisResponse> favorisResponses;

  FavoriteLoaded(this.favorisResponses);
}

class FavoriteError extends FavoriteState {
  final String error;

  FavoriteError(this.error);
}
