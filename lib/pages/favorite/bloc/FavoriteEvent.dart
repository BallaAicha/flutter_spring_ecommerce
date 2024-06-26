abstract class FavoriteEvent {}

class AddToFavoritesEvent extends FavoriteEvent {
  final int productId;
  final String customerId; // Add customerId field

  AddToFavoritesEvent(this.productId, this.customerId); // Update constructor
}

class LoadFavoritesEvent extends FavoriteEvent {
  final String customerId; // Add customerId field

  LoadFavoritesEvent(this.customerId); // Update constructor
}
