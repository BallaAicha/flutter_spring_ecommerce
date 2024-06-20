abstract class FavoriteEvent {}

class AddToFavoritesEvent extends FavoriteEvent {
  final int productId;

  AddToFavoritesEvent(this.productId);
}

class LoadFavoritesEvent extends FavoriteEvent {}
